import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    return Scaffold(
        drawer: Drawer(
            child: SideBar()
        ),
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          loginService.isUserLoggedIn()?
          IconButton(icon: Icon(Icons.live_tv_sharp), onPressed: () {  },):
          IconButton(icon: Icon(Icons.block), onPressed: () {  },)
        ],
      ),
      body: Center(
        child: Container(
          height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () {
                  loginService.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.white,
                            width: 2)
                    ),
                    child: loginService.isUserLoggedIn()?
                    Text("Sign Out",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)):
                    Text("Log In",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                ),
              ),
            )
        ),
      )
    );
  }
}