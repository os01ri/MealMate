
import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/helper_functions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/custom_intro_paint.dart';
import 'package:mealmate/router/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.wait([
      Future.delayed(AppConfig.splashScreenDuration).then((value) async {
        if (await HelperFunctions.isFirstTime()) {
          context.go(Routes.onboardingPage);
        }
        else if (!(await HelperFunctions.isAuth())) {
          context.go(Routes.signUpNamedPage);
        } else {
          context.go(Routes.recipesBrowsePage);
        }
      }),
    ]);
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: SafeArea(
        child: CustomPaint(
          painter: RPSCustomPainter(),
          size: context.deviceSize,
        ),
      ),
    );
  }
}
