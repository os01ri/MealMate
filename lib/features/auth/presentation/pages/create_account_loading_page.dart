import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/injection_container.dart';
import 'package:mealmate/router/app_routes.dart';

class CreateAccountLoadingPage extends StatefulWidget {
  const CreateAccountLoadingPage({super.key});

  @override
  State<CreateAccountLoadingPage> createState() => _CreateAccountLoadingPageState();
}

class _CreateAccountLoadingPageState extends State<CreateAccountLoadingPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(seconds: 3),
    )..forward().whenComplete(() {
        context.go(AppRoutes.recipesHome);
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: context.height * .07),
          Image.asset(PngPath.accountCreation),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return LinearProgressIndicator(
                color: AppColors.grey,
                valueColor: const AlwaysStoppedAnimation(AppColors.mainColor),
                value: _animationController.value,
                backgroundColor: AppColors.grey,
              );
            },
          ).paddingHorizontal(context.width * .1),
          Text(
            serviceLocator<LocalizationClass>().appLocalizations!.welcomeLoading,
            textAlign: TextAlign.center,
            style: const TextStyle().largeFontSize.bold,
          ),
          SizedBox(height: context.height * .07),
        ],
      ).padding(AppConfig.pagePadding).center(),
    );
  }
}
