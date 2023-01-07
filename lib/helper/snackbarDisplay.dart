import 'package:flutter/material.dart';

class SnackbarDisplay {
  void snackbarwithMessage(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(
        "Login Error! $message",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: (Colors.red),
      duration: Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
