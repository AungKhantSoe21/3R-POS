import 'package:flutter/material.dart';

OutlineInputBorder borderStyle() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(10)
  );
}

TextStyle errorTextStyle() {
  return const TextStyle(
    color: Colors.red,
  );
}

TextStyle inputTextStyle() {
  return const TextStyle(
    color: Colors.black,
    letterSpacing: 2,
    fontSize: 14,
  );
}

TextStyle hintStyle() {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );
}

TextStyle textStyle() {
  return const TextStyle(
    color: Colors.white,
    fontSize: 15,
  );
}
