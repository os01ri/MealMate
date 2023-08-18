import 'package:get_it/get_it.dart';
import 'package:mealmate/core/cubit/follow_cubit.dart';
import 'package:mealmate/core/cubit/language_cubit.dart';

import 'core/localization/localization_class.dart';
import 'features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'features/store/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'features/welcoming/presentation/cubit/user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  serviceLocator
      .registerLazySingleton<LocalizationClass>(() => LocalizationClass());

  serviceLocator.registerLazySingleton(() => CartCubit());

  serviceLocator.registerLazySingleton(() => AuthCubit());

  serviceLocator.registerLazySingleton(() => UserCubit());
  serviceLocator.registerLazySingleton(() => FollowCubit());
  serviceLocator.registerLazySingleton(() => LanguageCubit()..initLanguage());
}
