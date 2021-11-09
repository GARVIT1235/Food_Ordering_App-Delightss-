import 'package:Delightss/Pages/Cart.dart';
import 'package:Delightss/Pages/MyOrder.dart';
import 'package:Delightss/Pages/Setting.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> list = [
    homePage(),
    OrderPage(),
    CartPage(),
    SettingPage()
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: list[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.main_color,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.offline_pin_rounded),
              title: Text(
                'Order',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              title: Text(
                'Cart',
                style: TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              title: Text(
                'Account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF2c2b2b),
          onTap: _onItemTapped,
        ));
  }
}
