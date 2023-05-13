import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/router/app_routes.dart';

class CreateAccountLoading extends StatefulWidget {
  const CreateAccountLoading({super.key});

  @override
  State<CreateAccountLoading> createState() => _CreateAccountLoadingState();
}

class _CreateAccountLoadingState extends State<CreateAccountLoading> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void didChangeDependencies() {
    animationController = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(seconds: 3),
    )..forward().then((_) {
        context.go(Routes.recipesBrowsePage);
      });
    super.didChangeDependencies();
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
          SizedBox(
            height: context.height * .2,
          ),
          SizedBox(
            height: context.height * .6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: context.width,
                  height: context.height * .2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/png/account_creation.png'),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      color: AppColors.grey,
                      valueColor: AlwaysStoppedAnimation(AppColors.buttonColor),
                      value: animationController.value,
                      backgroundColor: AppColors.grey,
                    );
                  }, 
                ).paddingHorizontal(context.width * .2),
                Text(
                  'Personalizing Healthy Recipes For Your Helathy Life',
                  style: AppTextStyles.styleWeight600(fontSize: 14),
                )
              ],
            ),
          ),
          SizedBox(height: context.height * .2)
        ],
      ),
    );
  }
}
