import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../router/routes_names.dart';
import '../widgets/custom_intro_paint.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(AppConfig.splashScreenDuration).whenComplete(() async {
      if (await Helper.isFirstTimeOpeningApp()) {
        if (context.mounted) context.myGoNamed(RoutesNames.onboarding);
      } else if (Helper.isAuthSavedToStorage()) {
        Helper.setUserToken((Helper.getTokenFromStorage())!);
        if (context.mounted) context.myGoNamed(RoutesNames.recipesHome);
      } else {
        if (context.mounted) context.myGoNamed(RoutesNames.login);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: SafeArea(
        child: CustomPaint(
          painter: const RPSCustomPainter(),
          size: context.deviceSize,
        ),
      ),
    );
  }
}
