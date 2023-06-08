import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mealmate/core/ui/theme/them.dart';
import 'package:mealmate/core/ui/widgets/restart_widget.dart';
import 'package:mealmate/injection_container.dart' as di;
import 'package:mealmate/router/app_router.dart';
import 'package:mealmate/services/service_injection.dart';

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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Meal Mate',
        theme: AppTheme.getColor(),
        routerConfig: AppRouter.router,
        builder: botToastBuilder,
        locale: const Locale('ar', ''),
        supportedLocales: const [Locale('ar', ''), Locale('en', '')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
      ),
    );
  }
}
