import 'package:Delightss/Models/Popular.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/cartService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySelectionService extends ChangeNotifier {
  FirebaseFirestore _instance;
  PopularCategory _selectedCategory;

  PopularCategory get selectedCategory => _selectedCategory;
  set selectedCategory(PopularCategory value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void incrementSubCategoryAmount(BuildContext context) {
    if (_selectedCategory != null) {
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
          'cartItems.${selectedCategory.name}': FieldValue.increment(1)
        }).then((value) {
          double p = _selectedCategory.price as double;
          p++;
          notifyListeners();
        });
      } else {
        double p = _selectedCategory.price as double;
        p++;
        notifyListeners();
      }
    }
  }

  void decrementSubCategoryAmount(BuildContext context) {
    if (_selectedCategory != null) {
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
          'cartItems.${selectedCategory.name}': FieldValue.increment(-1)
        }).then((value) {
          double p = _selectedCategory.price as double;
          p--;
          notifyListeners();
        });
      } else {
        double p = _selectedCategory.price as double;
        p--;
        notifyListeners();
      }
    }
  }

  int get subCategoryAmount {
    int subCatAmount = 0;
    if (_selectedCategory != null) {
      subCatAmount = 0;
    }
    return subCatAmount;
  }
}
