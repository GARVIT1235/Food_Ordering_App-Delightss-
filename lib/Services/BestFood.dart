import 'package:Delightss/Models/best.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BestService {
  FirebaseFirestore _instance;
  List<BestCategory> _categories = [];

  List<BestCategory> getCategories() {
    return _categories;
  }

  Future<void> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('best Food');

    DocumentSnapshot snapshot =
        await categories.doc('Zron4i9qlKqnYujBgywX').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['Best Food'] as List<dynamic>;
      categoriesData.forEach((catData) {
        BestCategory cat = BestCategory.fromJson(catData);
        _categories.add(cat);
      });
    }
  }
}
