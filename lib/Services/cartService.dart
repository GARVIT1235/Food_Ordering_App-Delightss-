import 'dart:collection';
import 'package:Delightss/Models/Popular.dart';
import 'package:Delightss/Models/cartmodel.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/PopularFood.dart';
import 'package:Delightss/Services/catcartService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];
  FirebaseFirestore _instance;

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void add(BuildContext context, CartItem item) {
    _items.add(item);

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    Map<String, int> cartMap = Map();
    _items.forEach((CartItem item) {
      cartMap[item.category.name] = (item.category).price as int;
    });

    _instance = FirebaseFirestore.instance;
    _instance
        .collection('cart')
        .doc(loginService.loggedInUserModel.uid)
        .set({'cartItems': cartMap}).then((value) {
      notifyListeners();
    });
  }

  bool isSubCategoryAddedToCart(PopularCategory cat) {
    return _items.length > 0
        ? _items.any((CartItem item) => item.category.name == cat.name)
        : false;
  }

  double getShoppingCartTotalPrice() {
    double mainTotal = 0;
    _items.forEach((CartItem item) {
      PopularCategory itemSubCategory = (item.category);
      double total = itemSubCategory.price as double;
      mainTotal += total;
    });
    return mainTotal;
  }

  void remove(BuildContext context, CartItem item) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    PopularCategory subCat = (item.category);

    _instance = FirebaseFirestore.instance;
    _instance.collection('cart').doc(loginService.loggedInUserModel.uid).update(
        {'cartItems.${subCat.name}': FieldValue.delete()}).then((value) {
      (item.category).price = 0 as String;
      _items.remove(item);
      notifyListeners();
    });
  }

  void removeAll(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    _instance = FirebaseFirestore.instance;
    _instance
        .collection('cart')
        .doc(loginService.loggedInUserModel.uid)
        .update({'cartItems': FieldValue.delete()}).then((value) {
      _items.forEach((CartItem item) {
        (item.category).price = 0 as String;
      });
      _items.clear();
      notifyListeners();
    });
  }

  PopularCategory getCategoryFromCart(PopularCategory cat) {
    PopularCategory subCat = cat;
    if (_items.length > 0 &&
        _items.any((CartItem item) => item.category.name == cat.name)) {
      CartItem cartItem =
          _items.firstWhere((CartItem item) => item.category.name == cat.name);

      if (cartItem != null) {
        subCat = cartItem.category;
      }
    }

    return subCat;
  }

  void loadCartItemsFromFirebase(BuildContext context) {
    // clear the items up front
    if (_items.length > 0) {
      _items.clear();
    }

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    PopularService catService =
        Provider.of<PopularService>(context, listen: false);
    CategorySelectionService categorySelectionService =
        Provider.of<CategorySelectionService>(context, listen: false);

    if (loginService.isUserLoggedIn()) {
      _instance = FirebaseFirestore.instance;
      _instance
          .collection('cart')
          .doc(loginService.loggedInUserModel.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> cartItems =
              snapshot.get(FieldPath(['cartItems']));

          catService.getCategories().forEach((PopularCategory cat) {
            if (cartItems.keys.contains(cat.name)) {
              var amount = cartItems[cat.price] as int;
              (cat).price = amount as String;
              _items.add(CartItem(category: cat));

              // force resetting the selected subcategory to trigger a rebuild on the unit price widget
              if (categorySelectionService.selectedCategory != null &&
                  categorySelectionService.selectedCategory.name == cat.name) {
                categorySelectionService.selectedCategory = cat;
              }
            }
          });

          notifyListeners();
        }
      });
    }
  }
}
