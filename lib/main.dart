import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/routes.dart';

import 'package:r_pos/screens/splash_screen.dart';
import 'package:r_pos/themes.dart';
import 'package:r_pos/utils/constant_text.dart';

void main() async{
  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: getTheme(context),
      initialRoute: SplashScreen.route,
      routes: getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}