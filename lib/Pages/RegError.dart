import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/regUser.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegErrorPage extends StatefulWidget {
  @override
  RegErrorPageState createState() => RegErrorPageState();
}

class RegErrorPageState extends State<RegErrorPage> {
  @override
  Widget build(BuildContext context) {
    final X = MediaQuery.of(context).size.width;
    final Y = MediaQuery.of(context).size.height;
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String uid = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.uid
        : '';
    RegUserService cat1Service =
        Provider.of<RegUserService>(context, listen: false);
    int detail = cat1Service.getCategoriesCollectionFromFirebase(uid) as int;
    print(detail);
    if (detail == 1) {
      Navigator.of(context).pushReplacementNamed('/lerror');
    } else {
      Navigator.of(context).pushReplacementNamed('/detail');
    }

    return Scaffold(
      backgroundColor: AppColors.main_color,
      body: Container(
        padding: EdgeInsets.only(top: Y / 3 + 30),
        height: Y,
        width: X,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                height: Y * 0.2, child: Image.asset("assets/images/logo.jpg")),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
