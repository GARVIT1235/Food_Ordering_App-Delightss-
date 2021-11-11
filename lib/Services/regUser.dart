import 'package:cloud_firestore/cloud_firestore.dart';

class RegUserService {
  FirebaseFirestore _instance;

  Future<dynamic> getCategoriesCollectionFromFirebase(String uid) async {
    var data;
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('userRegister');

    DocumentSnapshot snapshot = await categories.doc(uid).get();
    if (snapshot.exists) {
      data = snapshot.data() as Map<String, dynamic>;
    }
    if (data['Details'] == "Yes")
      return 1;
    else
      return 0;
  }
}
