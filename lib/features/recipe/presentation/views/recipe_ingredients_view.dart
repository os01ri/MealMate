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
        const _RecipeHeader().padding(const EdgeInsets.all(8)),
        const _NutritionalValues(),
        const _NumberOfEaters().padding(const EdgeInsets.all(10)),
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
              ).padding(const EdgeInsets.all(8)),
          ],
        ).scrollable().expand(),
        MainButton(
          color: AppColors.buttonColor,
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          },
          width: context.width,
          text: 'Start Cocking!',
        ).padding(const EdgeInsets.all(8)).hero('button'),
      ],
    );
  }
}
