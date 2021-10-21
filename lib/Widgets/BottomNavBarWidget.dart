import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      navigateToScreens(_selectedIndex);
    }

    return BottomNavigationBar(
      backgroundColor: Colors.deepOrange,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.offline_pin_rounded),
          title: Text(
            'Order',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          title: Text(
            'Account',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFF2c2b2b),
      onTap: _onItemTapped,
    );
  }

  Function navigateToScreens(int index) {
    switch (index) {
      case 1:
        return () => Navigator.of(context).pushNamed('/home');
      case 2:
        return () => Navigator.of(context).pushNamed('/order');
      case 3:
        return () => Navigator.of(context).pushNamed('/cart');
      case 4:
        return () => Navigator.of(context).pushNamed('/setting');
    }
  }
}
