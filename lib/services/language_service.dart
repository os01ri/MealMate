import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

enum LangCode { ar, en }

List<Locale> supportedLocal = [
  localMap[LangCode.ar]!,
  localMap[LangCode.en]!,
];

final Locale defaultLocal = localMap[LangCode.ar]!;

final localMap = {
  LangCode.en: const Locale('en', 'US'),
  LangCode.ar: const Locale('ar', 'SY'),
};

class LanguageService {
  static late Locale currentLanguage;
  static late bool rtl;

  final BuildContext context;
  static LanguageService? _instance;

  LanguageService._singleton(this.context) {
    currentLanguage = _currentLanguage;
    rtl = _rtl;
  }

  factory LanguageService(BuildContext context) =>
      _instance ??= LanguageService._singleton(context);

  Locale get _currentLanguage => context.locale;

  bool get _rtl => context.locale == localMap[LangCode.ar]!;
}
