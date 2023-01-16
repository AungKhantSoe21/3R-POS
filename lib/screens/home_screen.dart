import 'dart:io';

import 'package:flutter/material.dart';
import 'package:r_pos/screens/home_navigation_screens/menu_screen.dart';
import 'package:r_pos/screens/home_navigation_screens/more_screen.dart';
import 'package:r_pos/screens/home_navigation_screens/order_screen.dart';
import 'package:r_pos/screens/home_navigation_screens/report_screen.dart';
import 'package:r_pos/screens/home_navigation_screens/table_screen.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/toast_message.dart';

class HomeScreen extends StatefulWidget {
  static String route = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;
  String appBarTitle = "Menu";
  IconData appBarIcon = Icons.restaurant;
  List<Widget> screens = [
    const OrderScreen(),
    const TableScreen(),
    const MenuScreen(),
    const ReportScreen(),
    const MoreScreen()
  ];

  // back key instance
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
  // back key instance

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
            switch (currentIndex) {
              case 0: {
                setState(() {
                  appBarTitle = "Order";
                  appBarIcon = Icons.notifications_active;
                });
              }
              break;
              case 1:{
                setState(() {
                  appBarTitle = "Table";
                  appBarIcon = Icons.title;
                });
              }
              break;
              case 2: {
                setState(() {
                  appBarTitle = "Menu";
                  appBarIcon = Icons.restaurant;
                });
              }
              break;
              case 3:{
                setState(() {
                  appBarTitle = "Report";
                  appBarIcon = Icons.assignment;
                });
              }
              break;
              default: {
                setState(() {
                  appBarTitle = "More";
                  appBarIcon = Icons.more_horiz;
                });
              }
            }
          }),
          elevation: 0,
          selectedIconTheme: const IconThemeData(size: 20),
          unselectedIconTheme: const IconThemeData(size: 15),
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items:  const [
            BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Order'),
            BottomNavigationBarItem(icon: Icon(Icons.title), label: 'Table'),
            BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Report'),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
          ],
        ),
        appBar: AppBar(
          leading: Icon(appBarIcon),
          title: Text(appBarTitle, style: TextStyle(color: Colors.black, fontFamily: poppinFont, fontSize: 16),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                radius: 21,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
              ),
            )
          ],
        ),
        body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      ),
    );
  }
}