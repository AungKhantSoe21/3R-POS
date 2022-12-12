import 'package:flutter/material.dart';
import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/themes.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: getTheme(),
      home: const HomeScreen(),
    );
  }
}