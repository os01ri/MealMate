import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color mainColor = Colors.blue;
  static const Color scaffoldBackgroundColor = Colors.white10;
  static const Color secondaryColor = Colors.white24;
  static const Color grey2 = Colors.grey;
  static const Color lightRed = Colors.grey;
  static const Color grey1 = Colors.grey;
  static const Color blue = Colors.grey;

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
