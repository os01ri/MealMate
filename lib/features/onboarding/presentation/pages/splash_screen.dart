import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/custom_intro_paint.dart';
import 'package:mealmate/router/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.wait([
      Future.delayed(const Duration(seconds: 1)).then((value) => context.go(Routes.onboardingPage)),
    ]);
    return Scaffold(
      backgroundColor: AppColors.orange, //const Color(0xff70b9be),
      body: SafeArea(
        child: CustomPaint(
          painter: RPSCustomPainter(),
          size: context.deviceSize,
        ),
      ),
    );
  }
}
