import 'package:flutter/material.dart';
import 'package:decoze/utils/app_color.dart';

// ==============
// App Font Size
// ===============
class AppFontSize {
  static const double extraSmall = 10.0;
  static const double small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double extraLarge = 18.0;
  static const double heading20 = 20.0;
  static const double heading24 = 24.0;
  static const double heading32 = 32.0;
}

// ==============
// App Font Weight
// ===============
class AppFontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

// ==============
// Input Field Type Enum
// ===============
enum InputFieldType {
  text,
  email,
  password,
  number,
  phone,
}

// ==============
// App Text Style
// ===============
class AppTextStyle {
  static TextStyle getTextStyle({
    double fontSize = AppFontSize.medium,
    FontWeight fontWeight = AppFontWeight.regular,
    Color color = AppColor.whitePure,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
