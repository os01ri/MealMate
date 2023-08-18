import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/prefs_keys.dart';

part 'language_state.dart';

const List<Locale> supportedLocales = [
  Locale('ar', ''),
  Locale('en', ''),
];

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());
  initLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(PrefsKeys.language)) {
      emit(state.copyWith(
        locale: Locale(pref.getString(PrefsKeys.language)!),
      ));
      return;
    } else {
      String localeName = Platform.localeName;
      for (var item in supportedLocales) {
        if (localeName.startsWith(item.languageCode)) {
          pref.setString(PrefsKeys.language, item.languageCode);
          emit(
            state.copyWith(
              locale: item,
            ),
          );
          return;
        }
      }
    }
    emit(
      state.copyWith(
        locale: const Locale('ar', ''),
      ),
    );
  }

  changeLanguage(Locale newLocale) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(PrefsKeys.language, newLocale.languageCode);
    serviceLocator<LocalizationClass>()
        .setAppLocalizations(await AppLocalizations.delegate.load(newLocale));
    emit(
      state.copyWith(
        locale: newLocale,
      ),
    );
  }
}
