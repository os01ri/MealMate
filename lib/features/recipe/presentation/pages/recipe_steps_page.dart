import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/router/app_routes.dart';

class RecipeStepsPage extends StatelessWidget {
  const RecipeStepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: RecipeAppBar(
        //   context: context,
        //   title: 'Pasta Preparation',
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: Image.asset(
        //         PngPath.saveInactive,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        body: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              PngPath.food,
              fit: BoxFit.fitWidth,
              width: context.width,
            ).positioned(top: 0),
            const _StepsSection().positioned(bottom: 0),
          ],
        ),
      ),
    );
  }
}

class _StepsSection extends StatelessWidget {
  const _StepsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * .65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Step 4',
            style: const TextStyle().bold.largeFontSize,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i < 4; i++)
                StepBullet(
                  isActive: false,
                  stepNumber: i,
                ),
              const StepBullet(
                isActive: true,
                child: Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              for (int i = 0; i < 2; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Checken Breasts',
                      style: const TextStyle().normalFontSize.semiBold,
                    ),
                    const Text(
                      '250 g',
                      style: TextStyle(),
                    ),
                  ],
                ).paddingAll(8),
                const Divider(),
              ],
            ],
          ),
          Text(
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa ',
            style: const TextStyle().normalFontSize.regular,
          ).paddingVertical(15).scrollable().expand(),
          Row(
            children: [
              MainButton(
                color: AppColors.grey,
                onPressed: () {
                  // pageController.animateToPage(
                  //   pageController.page!.ceil() - 1,
                  //   duration: AppConfig.pageViewAnimationDuration,
                  //   curve: Curves.ease,
                  // );
                  context.pop();
                },
                text: 'Previous',
                textColor: Colors.black,
              ).paddingAll(8).expand(),
              MainButton(
                color: AppColors.mainColor,
                onPressed: () {
                  context.go(Routes.recipesBrowsePage);
                },
                text: 'Finish Cooking',
              ).paddingAll(8).expand(),
            ],
          ),
        ],
      ).padding(AppConfig.pagePadding),
    );
  }
}

class StepBullet extends StatelessWidget {
  const StepBullet({
    super.key,
    this.child,
    this.stepNumber,
    required this.isActive,
  }) : assert(child != null || stepNumber != null);

  final Widget? child;
  final int? stepNumber;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      padding: const EdgeInsets.all(2),
      width: context.width * .05,
      height: context.width * .05,
      decoration: BoxDecoration(
        color: isActive ? AppColors.mainColor : Colors.white,
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(100),
      ),
      child: FittedBox(
        child: child ??
            Text(
              '${stepNumber!}',
              style: TextStyle(color: isActive ? Colors.white : Colors.black),
            ).center(),
      ),
    );
  }
}
