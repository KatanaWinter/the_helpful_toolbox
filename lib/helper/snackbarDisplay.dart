import 'package:flutter/material.dart';

void snackbarwithMessage(String message, BuildContext context, int type) {
  var snackBar = SnackBar(
    content: SelectableText(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: type == 1 ? (Colors.green[600]) : (Colors.red),
    duration: const Duration(seconds: 5),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
