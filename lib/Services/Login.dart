import 'package:Delightss/Models/Login.dart';
import 'package:Delightss/Services/File.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Map<String, String> map = Map();

class LoginService extends ChangeNotifier {
  LoginUserModel _userModel;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFirestore(Map usersModel) {
    firebaseFirestore
        .collection("users")
        .doc(loggedInUserModel.uid)
        .set({"userDetails": usersModel});
  }

  registerToFirestore() {
    firebaseFirestore
        .collection("userRegister")
        .doc(loggedInUserModel.uid)
        .set({"Details": (map['details'] = 'Yes')});
  }

  DirFile file = DirFile();

  LoginUserModel get loggedInUserModel => _userModel;

  Future<bool> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return false;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ) as GoogleAuthCredential;

    UserCredential userCreds =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCreds != null) {
      _userModel = LoginUserModel(
          uid: userCreds.user.uid,
          displayName: userCreds.user.displayName,
          photoUrl: userCreds.user.photoURL,
          email: userCreds.user.email);
    }
    notifyListeners();
    file.createFile('1');
    return true;
  }

  Future<void> signOut() async {
    file.createFile('0');
    await GoogleSignIn().signOut();
    _userModel = null;
  }

  bool isUserLoggedIn() {
    return _userModel != null;
  }
}
