import 'package:flutter/material.dart';

class LandingErrorPage extends StatefulWidget {
  @override
  LandingErrorPageState createState() => LandingErrorPageState();
}

class LandingErrorPageState extends State<LandingErrorPage> {
  @override
  Widget build(BuildContext context) {
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
