import 'package:flutter/material.dart';

extension RoutingExtension on BuildContext {
  Size get deviceSize => MediaQuery.sizeOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  double get height => deviceSize.height;

  double get width => deviceSize.width;
}
