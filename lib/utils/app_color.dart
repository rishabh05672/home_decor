// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';

class AppColor {
  static const Color backgroundColor = Color(0xff313437);
  static const Color primary500 = Color(0xffEAFF44);
  static const Color primary50 = Color(0xffFDFFEC);
  static const Color primary100 = Color(0xffF8FFC5);
  static const Color primary200 = Color(0xffF5FFA9);
  static const Color primary300 = Color(0xffF1FF82);
  static const Color primary400 = Color(0xffEEFF69);

  static const Color textSecondary500 = Color(0xff313437);
  static const Color textSecondary600 = Color(0xff353B40);
  static const Color textSecondary50 = Color(0xffEAEBEB);
  static const Color textSecondary100 = Color(0xffBFC0C1);
  static const Color textSecondary200 = Color(0xffA0A2A3);
  static const Color textSecondary300 = Color(0xff757779);
  static const Color textSecondary400 = Color(0xff5A5D5F);
  static const Color whitePure = Color(0xffffffff);

  static const Color warning = Color(0xffFFA03C);
}

extension contextUI on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
