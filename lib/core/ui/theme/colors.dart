import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color orange = Color(0xffe23e3e);
  static const Color deepOrange = Color(0xFF692409);
  static const Color yellow = Color(0xffffb661);
  static const Color grey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff1f1f1);
  static const Color grey2 = Colors.grey;
  static const Color lightRed = Colors.red;

  static const Color mainColor = orange;
  static const Color secondaryColor = Colors.white24;
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color buttonColor = orange;
  static const Color lightTextColor = Color(0xffA9A9A9);

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
