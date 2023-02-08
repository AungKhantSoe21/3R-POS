// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:r_pos/core/persistence/user_persistence.dart';
import 'package:r_pos/screens/auth_screens/login_screen.dart';
import 'package:r_pos/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static String route = 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String username = "";

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    final getUserPreference = await UserPersistence().getUserPreference();
    username = getUserPreference.toString() == "null" ? '' :  getUserPreference[0];
    await Future.delayed(Duration(seconds: 3));
    if(username == '') {
      log("message1");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LoginScreen())
      );
    } else {
      log("message");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 29,
                backgroundImage: AssetImage("assets/images/3R-POS.jpg"),
              ),
            ),
            Text("3R-POS", style: TextStyle(fontSize: 25),)
          ],
        ),
      )
    );
  }
}