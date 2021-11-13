import 'package:Delightss/Services/Details.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingErrorPage extends StatefulWidget {
  @override
  LandingErrorPageState createState() => LandingErrorPageState();
}

class LandingErrorPageState extends State<LandingErrorPage> {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String uid = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.uid
        : '';
    DetailService cat1Service =
        Provider.of<DetailService>(context, listen: false);
    cat1Service.getCategoriesCollectionFromFirebase(uid).then((value) {
      Navigator.of(context).pushReplacementNamed('/home');
    }).onError((error, stackTrace) {
      Navigator.of(context).pushReplacementNamed('/detail');
    });
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  "assets/images/loading.png",
                  fit: BoxFit.cover,
                ))),
        Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    ));
  }
}
