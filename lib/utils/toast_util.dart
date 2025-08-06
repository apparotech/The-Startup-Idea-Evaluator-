import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(String message, {Color bgColor = Colors.blue}) {

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: bgColor,
    textColor: Colors.blueAccent,
  );
}