import 'dart:io';

import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/toast_message.dart';

class HomeScreen extends StatefulWidget {
  static String route = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      toastMessage('Press back again to exit');
      return Future.value(false);
    }
    return exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: const Text("Dashboard", style: TextStyle(color: Colors.black, fontFamily: poppinFont),),
        ),
        body: Container(),
      ),
    );
  }
}