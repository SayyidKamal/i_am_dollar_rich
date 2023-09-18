import 'package:flutter/material.dart';

class ColorTheme {
  final Color background;
  final Color dollarSign;

  const ColorTheme._(this.background, this.dollarSign);

  static const ColorTheme classic =
      ColorTheme._(Color(0xFF007BFF), Color(0xFF6C757D));
  static const ColorTheme modern =
      ColorTheme._(Color(0xFF20C997), Color(0xFF343A40));
  static const ColorTheme bold =
      ColorTheme._(Color(0xFF0DCCA1), Color(0xFF000000));
  static const ColorTheme elegant =
      ColorTheme._(Color(0xFF001F3F), Color(0xFFFFD700));
  static const ColorTheme minimal =
      ColorTheme._(Color(0xFFFAFAFA), Color(0xFF9E9E9E));
}

// Usage Example:
// ColorTheme.currentTheme = ColorTheme.modern;
// Color bgColor = ColorTheme.currentTheme.background;
// Color dollarSignColor = ColorTheme.currentTheme.dollarSign;
