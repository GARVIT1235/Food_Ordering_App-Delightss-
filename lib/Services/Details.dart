import 'package:Delightss/Models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailService {
  FirebaseFirestore _instance;
  List<UserModel> _categories = [];
  List<UserModel> getCategories() {
    return _categories;
  }

  Future<void> getCategoriesCollectionFromFirebase(String uid) async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('users');

    DocumentSnapshot snapshot = await categories.doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['userDetails'] as List<dynamic>;
      categoriesData.forEach((catData) {
        UserModel cat = UserModel.fromJson(catData);
        _categories.add(cat);
      });
    } else
      return null;
  }
}
