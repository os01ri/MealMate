import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/helper.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/custom_intro_paint.dart';
import 'package:mealmate/router/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(AppConfig.splashScreenDuration).whenComplete(() async {
      if (await Helper.isFirstTime()) {
        context.go(AppRoutes.onboarding);
      } else if (await Helper.isAuth()) {
        Helper.setUserToken((await Helper.getTokenFromStorage())!);
        context.go(AppRoutes.recipesHome);
      } else {
        context.go(AppRoutes.login);
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
