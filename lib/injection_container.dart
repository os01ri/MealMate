import 'package:get_it/get_it.dart';

import 'core/localization/localization_class.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  serviceLocator.registerLazySingleton<LocalizationClass>(() => LocalizationClass());
}
