import 'package:Delightss/Models/regUser.dart';
import 'package:Delightss/Models/users.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegUserService {
  FirebaseFirestore _instance;
  List<RegUserModel> _categories = [];

  List<RegUserModel> getCategories() {
    return _categories;
  }

  LoginService loginService = LoginService();

  Future<void> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('userRegister');

    DocumentSnapshot snapshot =
        await categories.doc(loginService.loggedInUserModel.uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['Details'] as List<dynamic>;
      categoriesData.forEach((catData) {
        RegUserModel cat = RegUserModel.fromJson(catData);
        _categories.add(cat);
      });
    }
  }
}
