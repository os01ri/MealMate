import 'package:flutter/material.dart';

extension RoutingExtension on BuildContext {
  Size get deviceSize => MediaQuery.of(this).size;

  double get height => deviceSize.height;
  double get width => deviceSize.width;
}
