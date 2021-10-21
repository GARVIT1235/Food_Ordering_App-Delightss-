import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: MainAppBar(),
      body: Center(),
    );
  }
}
