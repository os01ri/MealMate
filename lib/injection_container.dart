import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import 'core/localization/localization_class.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  serviceLocator.registerLazySingleton<LocalizationClass>(() => LocalizationClass());

  serviceLocator<LocalizationClass>().setAppLocalizations(
    await AppLocalizations.delegate.load(const Locale('ar')),
  );
}
