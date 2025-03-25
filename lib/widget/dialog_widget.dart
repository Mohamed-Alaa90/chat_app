import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String message) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.scale,
    title: 'Error',
    desc: message,
    btnOkOnPress: () {},
  ).show();
}

showSuccessDialog(BuildContext context, void Function()? btnOkOnPress,String text) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: 'نجاح',
    desc: text,
    btnOkOnPress: btnOkOnPress,
  ).show();
}

showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder:
        (context) => const CircularProgressIndicator(color: Color(0xff79A3D3)),
  );
}
