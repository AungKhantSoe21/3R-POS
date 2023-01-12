import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:r_pos/core/persistence/user_persistence.dart';
import 'package:r_pos/screens/auth_screens/login_screen.dart';

import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/themes.dart';
import 'package:r_pos/utils/constant_text.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userId = "";

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  getUserData() async {
    final getUserPreference = await UserPersistence().getUserPreference();
    setState(() {
        userId = getUserPreference ?? '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: getTheme(),
      home: userId == ''
            ? const LoginScreen()
            : HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}