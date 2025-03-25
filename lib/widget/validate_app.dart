import 'package:get/get.dart';

String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email'.tr;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email'.tr;
    }
    return null;
  }


    String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password'.tr;
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters'.tr;
    }
    return null;
  }

   String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }