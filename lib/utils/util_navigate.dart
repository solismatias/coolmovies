import 'package:flutter/material.dart';

class UtilNavigate {
  static to(context, page) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static goBack(context) => Navigator.pop(context);
}
