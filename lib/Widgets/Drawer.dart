import 'package:Delightss/Services/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    LoginService loginService = Provider.of<LoginService>(context, listen: false);

    bool userLoggedIn = loginService.loggedInUserModel != null;

    return Scaffold(
        body: Container(
          color: Colors.deepOrangeAccent,
            padding: EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextButton(
                        onPressed: () async {
                          if (userLoggedIn) {
                            await loginService.signOut();
                            Navigator.of(context).pushReplacementNamed('/login');
                          }
                          else {
                            bool success = await loginService.signInWithGoogle();
                            if (success) {
                              Navigator.of(context).pushReplacementNamed('/home');
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Icon(userLoggedIn ? Icons.logout : Icons.login, color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(userLoggedIn ? 'Sign Out ' : 'Login ',
                                style: TextStyle(color: Colors.white, fontSize: 20)
                            )
                          ],
                        )
                    ),
                    SizedBox(height: 10),
                    Visibility(
                        visible: !userLoggedIn,
                        child: TextButton(
                            onPressed: ()  {

                            },
                            child: Row(
                              children: [
                                Icon(Icons.home, color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text('Welcome ',
                                    style: TextStyle(color: Colors.white, fontSize: 20)
                                )
                              ],
                            )
                        )
                    )
                  ],
                ),
              ],
            )
        )
    );
  }

}