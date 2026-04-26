import 'package:flutter/material.dart';
import 'package:decoze/utils/app_text_style.dart';

// ==============
// Common Button
// ===============
Widget commonButton({
  required String label,
  required VoidCallback onTap,
  required Color backgroundColor,
  required Color foregroundColor,
  double fontSize = AppFontSize.large,
  FontWeight fontWeight = AppFontWeight.bold,
  bool isLoading = false,
}) {
  return SizedBox(
    height: 56,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: isLoading
          ? CircularProgressIndicator(color: foregroundColor)
          : Text(
              label,
              style: AppTextStyle.getTextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: foregroundColor,
              ),
            ),
    ),
  );
}
