import 'package:flutter/material.dart';

void showCustomSnackBar(
    BuildContext context,
    String message, {
      Color? bgColor ,
      Duration duration = const Duration(seconds: 2),
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: duration,
    ),
  );
}
