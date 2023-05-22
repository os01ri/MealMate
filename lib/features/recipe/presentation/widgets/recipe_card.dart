part of '../pages/recipes_home_page.dart';

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: GestureDetector(
        onTap: () {
          context.push(Routes.recipeIntro);
        },
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Image.asset(
                PngPath.food,
                // fit: BoxFit.fitWidth,
                width: context.width * .4,
              ).hero(index == 0 ? 'picture' : '$index'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: context.width * .4,
                    child: Text(
                      'Indonesian chicken burger' * 3,
                      maxLines: 2,
                      softWrap: true,
                      style: const TextStyle().middleFontSize.semiBold,
                    ),
                  ),
                  SizedBox(
                    width: context.width * .4,
                    child: Text(
                      'By Adrianna Curl',
                      maxLines: 1,
                      style: const TextStyle(color: AppColors.lightTextColor).smallFontSize.semiBold,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
