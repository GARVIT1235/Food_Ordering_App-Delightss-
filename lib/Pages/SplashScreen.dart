import 'package:Delightss/Services/BestFood.dart';
import 'package:Delightss/Services/PopularFood.dart';
import 'package:Delightss/Services/slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    PopularService cat1Service =
        Provider.of<PopularService>(context, listen: false);
    BestService cat2Service = Provider.of<BestService>(context, listen: false);
    SliderService cat3Service =
        Provider.of<SliderService>(context, listen: false);

    Future.delayed(Duration(seconds: 4), () async {
      cat1Service.getCategoriesCollectionFromFirebase();
      cat3Service.getCategoriesCollectionFromFirebase();
      cat2Service.getCategoriesCollectionFromFirebase().then((value) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
    });

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
            SizedBox(
              height: Y * .06,
            ),
            AnimatedTextKit(animatedTexts: [
              TyperAnimatedText('WELCOME',
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  speed: Duration(milliseconds: 200))
            ]),
          ],
        ),
      ),
    );
  }
}
