import 'package:flutter/cupertino.dart';

class MainNavigationBarItemWidget extends BottomNavigationBarItem {
  final String initialLocation;

  MainNavigationBarItemWidget({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);
}
