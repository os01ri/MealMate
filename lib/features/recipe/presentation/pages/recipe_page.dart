import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/router/app_routes.dart';

part '../widgets/header_image.dart';
part '../widgets/recipe_budget_card.dart';
part '../widgets/recipe_tab_bar.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'Pasta',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              PngPath.saveInactive,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        dragStartBehavior: DragStartBehavior.down,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const _HeaderImage().paddingHorizontal(5),
              const _RecipeBudget().paddingVertical(8),
              const _TabBar(),
            ]),
          ),
          const _IngredientList(),
        ],
      ).padding(AppConfig.pagePadding),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: MainButton(
        color: AppColors.mainColor,
        onPressed: () {
          context.push(Routes.recipeStepsPage);
        },
        width: context.width,
        text: 'Start Cooking!',
      ).hero('button').padding(AppConfig.pagePadding),
    );
  }
}

class _IngredientList extends StatelessWidget {
  const _IngredientList();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, i) {
          return Row(
            children: [
              Text(
                'Chicken $i Breasts',
                style: const TextStyle().normalFontSize.semiBold,
              ),
              const Spacer(),
              const Text(
                '250 g',
                style: TextStyle(),
              ),
              Icon(
                switch (i) {
                  <= 3 => Icons.check_circle_outline_rounded,
                  _ => Icons.warning_amber_rounded,
                },
                color: switch (i) {
                  <= 3 => Colors.green,
                  _ => Colors.red,
                },
              ).paddingHorizontal(5),
            ],
          ).paddingAll(8);
        },
      ),
    );
  }
}
