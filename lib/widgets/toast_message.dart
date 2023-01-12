import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> toastMessage(String msg, {Color bgColor = Colors.black, Color txtColor = Colors.white, double fontSize = 16.0}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor,
      textColor: txtColor,
      fontSize: fontSize
  );
}