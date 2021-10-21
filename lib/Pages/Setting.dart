import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: MainAppBar(),
      body: Center(),
    );
  }
}
