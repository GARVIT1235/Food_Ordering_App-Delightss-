import 'package:Delightss/Models/Popular.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/cartService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySelectionService extends ChangeNotifier {
  FirebaseFirestore _instance;
  PopularCategory _selectedCategory;
  int amount = 0;

  PopularCategory get selectedCategory => _selectedCategory;
  set selectedCategory(PopularCategory value) {
    _selectedCategory = value;
    print(_selectedCategory);
    notifyListeners();
  }

  void incrementSubCategoryAmount(BuildContext context, PopularCategory value) {
    if (value != null) {
      _selectedCategory = value;
      LoginService loginService =
          Provider.of<LoginService>(context, listen: false);
      CartService cartService =
          Provider.of<CartService>(context, listen: false);

      if (cartService.isSubCategoryAddedToCart(value)) {
        _instance = FirebaseFirestore.instance;
        _instance
            .collection('cart')
            .doc(loginService.loggedInUserModel.uid)
            .update({
          'cartItems.${value.name}': FieldValue.increment(value.price)
        }).then((value) {
          _selectedCategory.amount++;
          notifyListeners();
        });
      }
    }
  }

  void decrementSubCategoryAmount(BuildContext context, PopularCategory value) {
    if (value != null) {
      _selectedCategory = value;
      LoginService loginService =
          Provider.of<LoginService>(context, listen: false);
      CartService cartService =
          Provider.of<CartService>(context, listen: false);

      if (cartService.isSubCategoryAddedToCart(_selectedCategory)) {
        _instance = FirebaseFirestore.instance;
        _instance
            .collection('cart')
            .doc(loginService.loggedInUserModel.uid)
            .update({
          'cartItems.${selectedCategory.name}':
              FieldValue.increment(-(value.price))
        }).then((value) {
          _selectedCategory.amount--;
          notifyListeners();
        });
      }
    }
  }

  int subCategoryAmount(PopularCategory value) {
    int subCatAmount = 0;
    if (value != null) {
      int subcatAmount = value.amount;
      return subcatAmount;
    }
    return subCatAmount;
  }
}
