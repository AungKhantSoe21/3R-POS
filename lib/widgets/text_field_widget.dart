import 'package:flutter/material.dart';
import 'package:r_pos/widgets/input_form_style.dart';

Widget textField(TextEditingController _controller, String _errMessage, {String hintText = ""}) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        focusedBorder: borderStyle(),
        contentPadding: const EdgeInsets.only(left: 15, top: 15),
        enabledBorder: borderStyle(),
        errorBorder: borderStyle(),
        focusedErrorBorder: borderStyle(),
        errorText: _errMessage,
        errorStyle: errorTextStyle(),
        hintText: hintText,
        hintStyle: hintStyle()

      ),
      style: inputTextStyle(),
      cursorColor: Colors.black,
    );
  }