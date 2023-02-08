import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget Loader(Color color, double width, {double size = 35}) {
  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: width,
      ),
    ),
  );
}
