import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
          'My Order',
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
