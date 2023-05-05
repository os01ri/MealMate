part of '../pages/recipe_page.dart';

class _RecipeIngredientsView extends StatelessWidget {
  const _RecipeIngredientsView({
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _RecipeHeader().paddingAll(8),
        const _NutritionalValues(),
        const _NumberOfEaters().paddingAll(10),
        Column(
          children: [
            for (int i = 0; i < 6; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Checken Breasts',
                    style: TextStyle(
                      color: i > 2 ? AppColors.lightRed : null,
                    ).normalFontSize.semiBold,
                  ),
                  Text(
                    '250 g',
                    style: TextStyle(
                      color: i > 2 ? AppColors.lightRed : null,
                    ),
                  ),
                ],
              ).paddingAll(8),
          ],
        ).scrollable().expand(),
        MainButton(
          color: AppColors.buttonColor,
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: AppConfig.pageViewAnimationDuration,
              curve: Curves.ease,
            );
          },
          width: context.width,
          text: 'Start Cocking!',
        ).paddingAll(8).hero('button'),
      ],
    );
  }
}
