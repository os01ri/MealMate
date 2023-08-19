import 'package:get_it/get_it.dart';

import 'core/cubit/follow_cubit.dart';
import 'core/cubit/language_cubit.dart';
import 'core/localization/localization_class.dart';
import 'features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'features/control_panel/presentation/cubit/control_panel_cubit/control_panel_cubit.dart';
import 'features/control_panel/presentation/cubit/favorite_recipes_cubit/favorite_recipes_cubit.dart';
import 'features/store/presentation/cubit/cart_cubit/cart_cubit.dart'; 

final serviceLocator = GetIt.instance;

Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  serviceLocator.registerLazySingleton(() => LanguageCubit()..initLanguage());

  serviceLocator.registerLazySingleton<LocalizationClass>(() => LocalizationClass());

  serviceLocator.registerLazySingleton(() => CartCubit());

  serviceLocator.registerLazySingleton(() => AuthCubit());

  serviceLocator.registerLazySingleton(() => ControlPanelCubit());

  serviceLocator.registerLazySingleton(() => FollowCubit());

  serviceLocator.registerLazySingleton(() => FavoriteRecipesCubit());
}
