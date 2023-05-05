import 'package:flutter/material.dart';

part 'font.dart';

TextTheme mealMateTextTheme(TextTheme base, Color textColor) => base
    .copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: _FontSize.heading_01,
        fontWeight: _light,
        letterSpacing: -1.5,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: _FontSize.heading_02,
        fontWeight: _light,
        letterSpacing: -0.5,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: _FontSize.heading_03,
        fontWeight: _bold,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: _FontSize.heading_04,
        fontWeight: _regular,
        letterSpacing: 0.25,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: _FontSize.heading_05,
        fontWeight: _bold,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: _FontSize.heading_06,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: _FontSize.subtitle_01,
        fontWeight: _bold,
        letterSpacing: 0.15,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: _FontSize.subtitle_02,
        fontWeight: _bold,
        letterSpacing: 0.1,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: _FontSize.body_01,
        fontWeight: _regular,
        letterSpacing: 0.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: _FontSize.body_02,
        fontWeight: _regular,
        letterSpacing: 0.25,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: _FontSize.button,
        fontWeight: _bold,
        letterSpacing: 1.25,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: _FontSize.caption,
        fontWeight: _regular,
        letterSpacing: 0.4,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontSize: _FontSize.overline,
        fontWeight: _regular,
        letterSpacing: 1.5,
      ),
    )
    .apply(
      fontFamily: _almaraiFamily,
      displayColor: textColor,
      bodyColor: textColor,
    );
