import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const largeTitle22 =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  static const largeTitleBlack22 =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black);
  static const largeTitle16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      overflow: TextOverflow.ellipsis);
  static const mediumGreyTitle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xff8A8A8E),
    overflow: TextOverflow.fade,
  );
  static const mediumWhiteTitle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    overflow: TextOverflow.fade,
  );
  static const mediumTitle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const mediumTitleBlue14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xff79A3D3),
  );
  static const mediumTitleBlack14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const mediumTitle17 = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff79A3D3));

  static const floatingTitle16 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff22292E));
  static const mediumTitleBlue16 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff6391F4));
}
