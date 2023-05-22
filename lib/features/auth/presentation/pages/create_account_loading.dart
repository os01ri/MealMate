import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/router/app_routes.dart';

class CreateAccountLoading extends StatefulWidget {
  const CreateAccountLoading({super.key});

  @override
  State<CreateAccountLoading> createState() => _CreateAccountLoadingState();
}

class _CreateAccountLoadingState extends State<CreateAccountLoading> with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(seconds: 3),
    )..forward().whenComplete(() {
        context.go(Routes.recipesBrowsePage);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: context.height * .07),
          Image.asset('assets/png/account_creation.png'),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return LinearProgressIndicator(
                color: AppColors.grey,
                valueColor: const AlwaysStoppedAnimation(AppColors.mainColor),
                value: animationController.value,
                backgroundColor: AppColors.grey,
              );
            },
          ).paddingHorizontal(context.width * .1),
          Text(
            'Personalizing Healthy Recipes For Your Healthy Life',
            textAlign: TextAlign.center,
            style: const TextStyle().largeFontSize.bold,
          ),
          SizedBox(height: context.height * .07),
        ],
      ).padding(AppConfig.pagePadding).center(),
    );
  }
}
