import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightTextFieldStyle() {
    return TextStyle(
        color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w500);
  }
}
