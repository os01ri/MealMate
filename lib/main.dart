import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mealmate/core/localization/localization_class.dart';

import 'core/cubit/language_cubit.dart';
import 'core/ui/theme/them.dart';
import 'core/ui/widgets/restart_widget.dart';
import 'dependency_injection.dart' as di;
import 'dependency_injection.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  di.init();
  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    /////////////
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocConsumer<LanguageCubit, LanguageState>(
        bloc: serviceLocator<LanguageCubit>(),
        listener: (context, state) async {
          serviceLocator<LocalizationClass>().setAppLocalizations(
              await AppLocalizations.delegate.load(state.locale!));
        },
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Meal Mate',
            theme: AppTheme.getColor(),
            routerConfig: AppRouter.router,
            builder: botToastBuilder,
            locale: state.locale,
            supportedLocales: supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
