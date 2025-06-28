import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle title({
    double? fontSize,
    Color? color,
   FontWeight? fontWeight,
   TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 28,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
      decoration: decoration, 
    );
  }
  static TextStyle subTitle({
    double? fontSize,
    Color? color,
    FontWeight? fontweight,
    TextDecoration? decoration, 
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontweight ?? FontWeight.bold,
      color: color,
      decoration: decoration,
    );
  }
  static TextStyle medium({
    double? fontSize,
    Color? color,
    FontWeight? fontweight,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      fontWeight: fontweight ?? FontWeight.bold,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle caption({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
      decoration: decoration,
    );
  }
}