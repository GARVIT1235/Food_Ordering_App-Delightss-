import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: MainAppBar(),
      body: Center(),
    );
  }
}
