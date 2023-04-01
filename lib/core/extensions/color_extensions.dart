import 'dart:ui';

extension ColorParser on Color {
  String toHex() => value.toRadixString(16).replaceRange(0, 2, "#");
}

extension StringParser on String {
  Color toColor() => Color(int.parse(replaceAll("#", "0xff")));
}
