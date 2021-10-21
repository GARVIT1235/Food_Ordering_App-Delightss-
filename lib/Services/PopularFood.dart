import 'package:Delightss/Models/Popular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopularService {
  FirebaseFirestore _instance;
  List<PopularCategory> _categories = [];

  List<PopularCategory> getCategories() {
    return _categories;
  }

  Future<void> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('Food');

    DocumentSnapshot snapshot =
        await categories.doc('4aNe5JvyZys6WwxfKU0x').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['Popular Food'] as List<dynamic>;
      categoriesData.forEach((catData) {
        PopularCategory cat = PopularCategory.fromJson(catData);
        _categories.add(cat);
      });
    }
  }
}
