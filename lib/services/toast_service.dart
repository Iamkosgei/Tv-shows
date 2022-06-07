import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';

class ToastService {
  void showErrorToast(String message) {
    _buildToast(message, isError: true);
  }

  void showSuccessToast(String message) {
    _buildToast(message);
  }

  void _buildToast(String message, {bool isError = false}) {
    Flushbar<dynamic>(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8),
    ).show(
      navigatorKey.currentContext!,
    );
  }
}
