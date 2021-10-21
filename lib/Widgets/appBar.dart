import 'package:Delightss/Services/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SearchWidget.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  MainAppBarState createState() => MainAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(190);
}

class MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String imgPath = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.photoUrl
        : '';
    return AppBar(
      title: TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.location_on_sharp, color: Colors.black),
          label: Text(
            'address',
            style: TextStyle(color: Colors.black),
          )),
      actions: [
        loginService.isUserLoggedIn()
            ? Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(10),
                child: ClipOval(child: Image.network(imgPath)))
            : IconButton(
                icon: Icon(Icons.block),
                onPressed: () {},
              )
      ],
      flexibleSpace: SearchWidget(),
    );
  }
}
