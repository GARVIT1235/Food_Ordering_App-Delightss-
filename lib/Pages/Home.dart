import 'package:Delightss/Models/users.dart';
import 'package:Delightss/Pages/Cart.dart';
import 'package:Delightss/Pages/MyOrder.dart';
import 'package:Delightss/Pages/Setting.dart';
import 'package:Delightss/Services/Details.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Widgets/BestFoodWidget.dart';
import 'package:Delightss/Widgets/BottomNavBarWidget.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/Widgets/PopularFoodsWidget.dart';
import 'package:Delightss/Widgets/SearchWidget.dart';
import 'package:Delightss/Widgets/Slider.dart';
import 'package:Delightss/Widgets/TopMenus.dart';
import 'package:Delightss/Widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

List<UserModel> model;

class _HomePageState extends State<HomePage> {
  final List<Widget> list = [
    HomePage(),
    OrderPage(),
    CartPage(),
    SettingPage()
  ];
  @override
  void initState() {
    super.initState();
    DetailService cat2Service = DetailService();
    cat2Service.getCategoriesCollectionFromFirebase();
    model = cat2Service.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchWidget(),
            ImageCarousel(),
            TopMenus(),
            PopularFoodsWidget(),
            BestFoodWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
