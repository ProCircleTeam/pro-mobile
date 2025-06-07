import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppFlushBar {
  showError({
    String? title,
    required String message,
    required BuildContext context,
    int? durationInSeconds,
  }) {
    return Flushbar(
      title: title,
      message: message,
      backgroundColor: const Color.fromARGB(255, 151, 26, 17),
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      duration: Duration(seconds: durationInSeconds ?? 3),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  showSuccess({
    String? title,
    required String message,
    required BuildContext context,
    int? durationInSeconds,
  }) {
    return Flushbar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }
}
