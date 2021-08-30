import 'package:Delightss/Services/Login.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget{
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
   LoginService loginService = Provider.of<LoginService>(context, listen: false);
    Future.delayed(Duration(seconds: 2), () async {
            if (loginService.isUserLoggedIn())
              Navigator.of(context).pushReplacementNamed('/home');
            else
              Navigator.of(context).pushReplacementNamed('/login');
    });
    final X = MediaQuery.of(context).size.width;
    final Y = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Container(
        padding: EdgeInsets.only(top: Y/3+30),
        height: Y,
        width: X,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: Y*0.2,
                child: Image.asset("assets/images/logo.jpg")
            ),
            SizedBox(
              height: Y*.06,
            ),
            AnimatedTextKit(
                animatedTexts:[
                  TyperAnimatedText('WELCOME',
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      speed: Duration(milliseconds: 200)
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }
}
