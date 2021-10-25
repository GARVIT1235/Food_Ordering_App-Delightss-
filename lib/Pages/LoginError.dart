import 'package:flutter/material.dart';

class LoginErrorPage extends StatefulWidget {
  @override
  LoginErrorPageState createState() => LoginErrorPageState();
}

class LoginErrorPageState extends State<LoginErrorPage> {
  @override
  Widget build(BuildContext context) {
    final X = MediaQuery.of(context).size.width;
    final Y = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.deepOrange,
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
