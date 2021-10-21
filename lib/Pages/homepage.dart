import 'package:Delightss/Widgets/BestFoodWidget.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/Widgets/PopularFoodsWidget.dart';
import 'package:Delightss/Widgets/Slider.dart';
import 'package:Delightss/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ImageCarousel(),
            SizedBox(
              height: 20,
            ),
            PopularFoodsWidget(),
            BestFoodWidget(),
          ],
        ),
      ),
    );
  }
}
