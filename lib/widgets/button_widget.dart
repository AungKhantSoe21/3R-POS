import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';

Widget buttonWidget(String _buttonText, dynamic _func) {
  return SizedBox(
    width: 100,
    height: 35,
    child: ElevatedButton(
      onPressed: _func(), 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        shadowColor: MaterialStateProperty.all(Colors.transparent)
      ),
      child: Text(_buttonText, style: TextStyle(fontSize: 14, color: Colors.black),)
    ),
  );
}