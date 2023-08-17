part of '../pages/recipes_home_page.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: GestureDetector(
        onTap: () {
          context.myPushNamed(RoutesNames.recipeIntro, extra: recipe);
        },
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                hash: recipe.hash!,
                borderRadius: BorderRadius.circular(15),
                url: recipe.url!,
                width: context.width * .4,
                height: context.height * .25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: context.width * .4,
                    child: Text(
                      recipe.name!,
                      maxLines: 2,
                      softWrap: true,
                      style: const TextStyle().middleFontSize.semiBold,
                    ),
                  ),
                  SizedBox(
                    width: context.width * .4,
                    child: Text(
                      'أدريانا كرول',
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
