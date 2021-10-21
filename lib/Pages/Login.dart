import 'package:Delightss/Services/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final X = MediaQuery.of(context).size.width;
    final Y = MediaQuery.of(context).size.height;
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Container(
            child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.4,
                child: Image.asset('assets/images/background.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              height: Y,
              width: X,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: ClipOval(
                      child: Container(
                          width: 180,
                          height: 180,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Hero(
                              tag: 'assets/images/logo.jpg',
                              child: Image(
                                  image:
                                      AssetImage('assets/images/logo.jpg')))),
                    ),
                  ),
                  SizedBox(height: Y * 0.07),
                  Text('WELCOME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Y * 0.05,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: Y * 0.04),
                  Container(
                      margin: EdgeInsets.only(
                          left: X * 0.05, right: X * 0.05, bottom: Y * 0.02),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () async {
                            bool success =
                                await loginService.signInWithGoogle();

                            if (success) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/detail');
                            } else {
                              CircularProgressIndicator();
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: Text("Sign In",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: X * 0.05, right: X * 0.05, bottom: Y * 0.02),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/home');
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: Text("Guest",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      )),
                  SizedBox(height: Y * 0.05)
                ],
              ),
            )
          ],
        )));
  }
}
