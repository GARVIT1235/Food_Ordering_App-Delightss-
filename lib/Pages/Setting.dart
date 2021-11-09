import 'package:Delightss/Models/users.dart';
import 'package:Delightss/Services/Details.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String imgPath;
  List<UserModel> user;
  @override
  Widget build(BuildContext context) {
    DetailService cats = Provider.of<DetailService>(context, listen: false);
    user = cats.getCategories();
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    imgPath = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.photoUrl
        : '';
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: AppBar(
        title: Text(
          'Account',
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
      body: loginService.isUserLoggedIn()
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //for circle avtar image
                  _getHeader(),
                  SizedBox(
                    height: 10,
                  ),
                  _profileName(user[0].name),
                  SizedBox(
                    height: 14,
                  ),
                  _heading("Personal Details"),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          //row for each deatails
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(loginService.loggedInUserModel.email),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black87,
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(user[0].phone),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black87,
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(user[0].address),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black87,
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text(user[0].age),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black87,
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text(user[0].dob),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _heading("Settings"),
                  SizedBox(
                    height: 6,
                  ),
                  _settingsCard(),
                  // Spacer(),
                  InkWell(
                    onTap: () async {
                      await loginService.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                    },
                    child: Container(
                        color: AppColors.main_color,
                        margin: EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 18),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            )
          : Center(
              child: Text(
                "Login In",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.main_color),
              ),
            ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      imgPath,
                    ))
                // color: Colors.orange[100],
                ),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.dashboard_customize),
              title: Text("About Us"),
            ),
            Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.topic),
              title: Text("Change Theme"),
            )
          ],
        ),
      ),
    );
  }
}
