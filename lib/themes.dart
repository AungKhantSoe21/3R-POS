import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    backgroundColor: primaryColor,
    fontFamily: poppinFont,
    textTheme: Theme.of(context).textTheme.apply(
      fontSizeFactor: 0.9,
      fontFamily: poppinFont
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}