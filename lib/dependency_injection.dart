import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import 'core/localization/localization_class.dart';
import 'features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'features/store/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'features/welcoming/presentation/cubit/user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  serviceLocator.registerLazySingleton<LocalizationClass>(() => LocalizationClass());

  serviceLocator<LocalizationClass>().setAppLocalizations(
    await AppLocalizations.delegate.load(const Locale('ar')),
  );
  serviceLocator.registerLazySingleton(() => CartCubit());
  
  serviceLocator.registerLazySingleton(() => AuthCubit());

  serviceLocator.registerLazySingleton(() => UserCubit());
}
