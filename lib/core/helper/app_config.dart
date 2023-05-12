import 'package:flutter/material.dart';

class AppConfig {
  AppConfig._();

  static Duration get splashScreenDuration => const Duration(milliseconds: 800);

  static Duration get animationDuration => const Duration(milliseconds: 8000);

  static Duration get pageViewAnimationDuration => const Duration(milliseconds: 400);

  static Duration get navigationAnimationDuration => const Duration(milliseconds: 400);

  static EdgeInsets get pagePadding => const EdgeInsets.only(left: 15, right: 15, bottom: 15);

  static BorderRadius get borderRadius => BorderRadius.circular(15);
}
