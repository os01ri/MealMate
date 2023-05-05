import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';

import 'core/ui/widgets/restart_widget.dart';
import 'router/app_router.dart';
import 'services/screen_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        title: 'Meal Mate',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          ScreenService(context, context.orientation);
          child = botToastBuilder(context, child);
          return child;
        },
      ),
    );
  }
}
