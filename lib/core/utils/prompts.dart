import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Prompts {
  static successSnackBar(String successMsg) {
    return Get.snackbar(
      duration: Duration(milliseconds: 1500),
      'Success',
      successMsg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  static errorSnackBar(String errorMsg) {
    return Get.snackbar(
      duration: Duration(milliseconds: 1500),
      'Error',
      errorMsg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
