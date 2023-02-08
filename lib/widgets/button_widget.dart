import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';

Widget buttonWidget(String buttonText, dynamic func) {
  return SizedBox(
    width: 100,
    height: 35,
    child: ElevatedButton(
      onPressed: func(), 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        shadowColor: MaterialStateProperty.all(Colors.transparent)
      ),
      child: Text(buttonText, style: const TextStyle(fontSize: 14, color: Colors.black),)
    ),
  );
}