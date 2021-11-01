import 'package:Delightss/Models/users.dart';
import 'package:Delightss/Services/Details.dart';
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
    DetailService cats = Provider.of<DetailService>(context, listen: false);
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String imgPath = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.photoUrl
        : '';
    List<UserModel> user = cats.getCategories();
    return AppBar(
      title: loginService.isUserLoggedIn()
          ? TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.location_on_sharp, color: Colors.black),
              label: Text(
                user[0].address,
                overflow: TextOverflow.clip,
                style: TextStyle(color: Colors.black),
              ))
          : TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.location_on_sharp, color: Colors.black),
              label: Text(
                ' ',
                style: TextStyle(color: Colors.black),
              )),
      actions: [
        loginService.isUserLoggedIn()
            ? Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(10),
                child: ClipOval(child: Image.network(imgPath)))
            : Container()
      ],
      flexibleSpace: SearchWidget(),
    );
  }
}
