import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget positioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      );

  Widget padding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);

  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingHorizontal(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  Widget paddingVertical(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  Widget scrollable() => SingleChildScrollView(child: this);

  Widget center() => Center(child: this);

  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget hero(String tag) => Hero(tag: tag, child: this);
}
