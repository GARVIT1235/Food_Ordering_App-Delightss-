import 'package:Delightss/Services/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    bool userLoggedIn = loginService.loggedInUserModel != null;
    String imgPath = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.photoUrl
        : '';
    return Scaffold(
        body: Container(
            color: Colors.deepOrangeAccent,
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Visibility(
                        visible: true,
                        child: loginService.isUserLoggedIn()
                            ? Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  imgPath,
                                  fit: BoxFit.cover,
                                ))
                            : Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: IconButton(
                                  icon: Icon(Icons.login_rounded),
                                  onPressed: () {},
                                ))),
                    Divider(),
                    SizedBox(height: 10),
                    Visibility(
                        visible: true,
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                Text('Welcome ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ))),
                    Visibility(
                        visible: true,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/home');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.home, color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text('Home',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ))),
                    Visibility(
                        visible: true,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/order');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.offline_pin_rounded,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text('Order ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ))),
                    Visibility(
                        visible: true,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/cart');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.card_giftcard,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text('Cart ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ))),
                    Visibility(
                        visible: true,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/setting');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.supervised_user_circle,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text('Setting ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ))),
                    Divider(),
                    SizedBox(height: 10),
                    TextButton(
                        onPressed: () async {
                          if (userLoggedIn) {
                            await loginService.signOut();
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          } else {
                            bool success =
                                await loginService.signInWithGoogle();
                            if (success) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Icon(userLoggedIn ? Icons.logout : Icons.login,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(userLoggedIn ? 'Sign Out ' : 'Login ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))
                          ],
                        )),
                  ],
                ),
              ],
            )));
  }
}
