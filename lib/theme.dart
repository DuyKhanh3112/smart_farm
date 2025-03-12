import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeApp {
  static ThemeData themeData() {
    return ThemeData.from(
      colorScheme: ColorScheme.light(
        primary: Colors.green[800]!,
        brightness: Brightness.light,
        outline: Colors.black54,
        outlineVariant: Colors.grey,
      ),
    );
    // return ThemeData.light(useMaterial3: true);
  }

  static TextStyle textStyle({
    Color? color,
    double fontSize = 14,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? Get.theme.colorScheme.onSurface,
      fontSize: fontSize,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
