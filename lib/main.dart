import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:r_pos/core/persistence/user_persistence.dart';
import 'package:r_pos/screens/auth_screens/login_screen.dart';
import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/themes.dart';
import 'package:r_pos/utils/constant_text.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username = "";

  @override
  void initState() {
    FlutterNativeSplash.remove();
    getUserData();
    super.initState();
  }

  getUserData() async {
    final getUserPreference = await UserPersistence().getUserPreference();
    setState(() {
        username = getUserPreference.toString() == "null" ? '' :  getUserPreference[0];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: getTheme(context),
      home: username == ''
            ? const LoginScreen()
            : HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}