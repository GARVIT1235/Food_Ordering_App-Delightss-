import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/Widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String imgPath = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.photoUrl
        : '';
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          loginService.isUserLoggedIn()
              ? Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(10),
                  child: ClipOval(child: Image.network(imgPath)))
              : Container()
        ],
      ),
      body: Center(),
    );
  }
}
