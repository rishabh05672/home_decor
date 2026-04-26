import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_text_style.dart';
import 'package:flutter/material.dart';

// ==============
// Common Text Field
// ===============
Widget commonTextField({
  required String hint,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required TextEditingController controller,
  InputFieldType fieldType = InputFieldType.text,
  Function(String?)? onChanged,
}) {
  TextInputType getKeyboardType() {
    switch (fieldType) {
      case InputFieldType.email:
        return TextInputType.emailAddress;
      case InputFieldType.number:
        return TextInputType.number;
      case InputFieldType.phone:
        return TextInputType.phone;
      case InputFieldType.text:
      case InputFieldType.password:
        return TextInputType.text;
    }
  }

  bool isObscure() {
    return fieldType == InputFieldType.password;
  }

  return TextFormField(
    onChanged: onChanged,
    style: AppTextStyle.getTextStyle(
      color: AppColor.primary50,
      fontSize: AppFontSize.heading20,
      fontWeight: AppFontWeight.bold,
    ),
    keyboardType: getKeyboardType(),
    obscureText: isObscure(),
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyle.getTextStyle(
        color: AppColor.textSecondary50,
        fontSize: AppFontSize.medium,
        fontWeight: AppFontWeight.regular,
      ),
      prefixIcon: Icon(prefixIcon, color: AppColor.textSecondary50),
      suffixIcon: Icon(suffixIcon),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.textSecondary500, width: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
