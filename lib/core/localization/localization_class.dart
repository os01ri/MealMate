import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationClass {
  AppLocalizations? appLocalizations;
  AppLocalizations? get getAppLocalizations => appLocalizations;

  void setAppLocalizations(AppLocalizations appLocalizations) {
    this.appLocalizations = appLocalizations;
  }
}
