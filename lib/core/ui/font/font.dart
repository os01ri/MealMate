part of 'typography.dart';

FontWeight get _light => FontWeight.w300;
FontWeight get _regular => FontWeight.normal;
FontWeight get _bold => FontWeight.bold;
FontWeight get _semiBold => FontWeight.w600;
FontWeight get _extraBold => FontWeight.w900;

String get _almaraiFamily => 'Almarai';

extension FamilyUtils on TextStyle {
  TextStyle get extraBold => copyWith(fontWeight: _extraBold);
  TextStyle get bold => copyWith(fontWeight: _bold);
  TextStyle get semiBold => copyWith(fontWeight: _semiBold);
  TextStyle get regular => copyWith(fontWeight: _regular);
  TextStyle get light => copyWith(fontWeight: _light);
}

extension FontSizeUtils on TextStyle {
  TextStyle get smallFontSize => copyWith(fontSize: _FontSize.caption);
  TextStyle get normalFontSize => copyWith(fontSize: _FontSize._body_01FontSize);
  TextStyle get largeFontSize => copyWith(fontSize: _FontSize._heading_06FontSize);
  TextStyle get xLargeFontSize => copyWith(fontSize: _FontSize._heading_03FontSize);
}

abstract class _FontSize {
  static double get heading_01 => _heading_01FontSize;
  static double get heading_02 => _heading_02FontSize;
  static double get heading_03 => _heading_03FontSize;
  static double get heading_04 => _heading_04FontSize;
  static double get heading_05 => _heading_05FontSize;
  static double get heading_06 => _heading_06FontSize;
  static double get subtitle_01 => _subtitle_01FontSize;
  static double get subtitle_02 => _subtitle_02FontSize;
  static double get button => _buttonFontSize;
  static double get body_01 => _body_01FontSize;
  static double get body_02 => _body_02FontSize;
  static double get caption => _captionFontSize;
  static double get overline => _overlineFontSize;

  static const double _heading_01FontSize = 46;
  static const double _heading_02FontSize = 36;
  static const double _heading_03FontSize = 28;
  static const double _heading_04FontSize = 24;
  static const double _heading_05FontSize = 20;
  static const double _heading_06FontSize = 22;
  static const double _subtitle_01FontSize = 18;
  static const double _subtitle_02FontSize = 16;
  static const double _buttonFontSize = 18;
  static const double _body_01FontSize = 16;
  static const double _body_02FontSize = 14;
  static const double _captionFontSize = 12;
  static const double _overlineFontSize = 10;
}
