import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const mainColor = Colors.blue;
  static const scaffoldBackgroundColor = Colors.white10;
  static const secondaryColor = Colors.white24;
  static const grey2 = Colors.grey;
  static const lightRed = Colors.grey;
  static const grey1 = Colors.grey;
  static const blue = Colors.grey;

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
