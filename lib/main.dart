//@dart=2.9
import 'package:flutter/material.dart';
import 'package:ecom_admin_panel/category.dart';
import 'package:ecom_admin_panel/completeorders.dart';
import 'package:ecom_admin_panel/employee_list.dart';
import 'package:ecom_admin_panel/orders.dart';
import 'package:ecom_admin_panel/products.dart';
import 'package:ecom_admin_panel/regions.dart';
import 'package:ecom_admin_panel/registor_employee.dart';
import 'package:ecom_admin_panel/registor_shop.dart';
import 'package:ecom_admin_panel/users.dart';

import 'banners.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delightss',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MyHomePage(title: 'Admin Panel for Ecommerce App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  TabController tabController;
  int active = 0;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 10, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: listDrawerItems(true),
        backgroundColor: Color(0xffebebeb),
        body: Row(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: listDrawerItems(true),
                )),
            Expanded(
              flex: 9,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Regions(),
                  Banners(),
                  ShopRegister(),
                  UsersView(),
                  Category(),
                  RegistrationEmployee(),
                  EmployeeList(),
                  Products(),
                  Orders(),
                  CompleteOrders()
                ],
              ),
            )
          ],
        ));
  }

  Widget listDrawerItems(bool drawerStatus) {
    return Container(
      color: Color(0xff172B4D),
      child: ListView(
        children: <Widget>[
          FlatButton(
            color: tabController.index == 0
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            onPressed: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
                child: Row(children: [
                  Icon(
                    Icons.dashboard,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          ListTile(
            tileColor: tabController.index == 1
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text(
              "Regions",
              style: TextStyle(color: Colors.grey.shade300),
            ),
            leading: Icon(
              Icons.location_on_outlined,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(0);
              setState(() {});
            },
          ),
          ListTile(
            tileColor: tabController.index == 6
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Banners Manage",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.image_outlined,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(1);
              setState(() {});
            },
          ),
          ListTile(
            tileColor: tabController.index == 2
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Users", style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.person_outline,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(3);
              setState(() {});
            },
          ),
          ListTile(
            tileColor: tabController.index == 2
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title:
                Text("Category", style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.category_outlined,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(4);
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Products',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          ListTile(
            tileColor: tabController.index == 3
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("New Product",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.add_business_outlined,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(2);
              setState(() {});
            },
          ),
          ListTile(
            tileColor: tabController.index == 5
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Active Products",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.add_business_outlined,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(7);
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Orders',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          ListTile(
            tileColor: tabController.index == 5
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Progress Orders",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(8);
              setState(() {});
            },
          ),
          ListTile(
            tileColor: tabController.index == 6
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Complete Orders",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.check_circle_outline,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(9);
              setState(() {});
            },
          ),
          ListTile(
            tileColor: tabController.index == 4
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Cancel Orders",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.leave_bags_at_home,
              color: Colors.grey.shade300,
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Employees',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          ListTile(
            tileColor: tabController.index == 5
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("New Delivery Boy",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.person_add,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(5);
            },
          ),
          ListTile(
            tileColor: tabController.index == 6
                ? Color(0xff172B4D)
                : Color(0xff172B4D),
            title: Text("Delivery Boys",
                style: TextStyle(color: Colors.grey.shade300)),
            leading: Icon(
              Icons.delivery_dining,
              color: Colors.grey.shade300,
            ),
            onTap: () {
              tabController.animateTo(6);
            },
          ),
        ],
      ),
    );
  }
}
