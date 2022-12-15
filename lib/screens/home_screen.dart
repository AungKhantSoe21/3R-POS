import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String route = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Container(),
    );
  }
}