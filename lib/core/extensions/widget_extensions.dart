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

  Widget scrollable() => SingleChildScrollView(child: this);

  Widget center() => Center(child: this);

  Widget expand() => Expanded(child: this);

  Widget hero(String tag) => Hero(tag: tag, child: this);
}
