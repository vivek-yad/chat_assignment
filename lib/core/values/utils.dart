import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  static success(message) {
    return Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.warning),
    );
  }
  static errors(message) {
    return Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.warning),
    );
  }
}
