part of '../pages/recipes_home_page.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    this.padding,
    this.width,
    this.height,
  });

  final RecipeModel recipe;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.myPushNamed(RoutesNames.recipeIntro, extra: recipe),
      child: Container(
        height: 250,
        margin: padding,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            CachedNetworkImage(
              hash: recipe.hash!,
              borderRadius: BorderRadius.circular(15),
              url: recipe.url!,
              width: width ?? context.width * .43,
              height: height ?? 170,
            ),
            SizedBox(
              width: width ?? context.width * .43,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    recipe.name!,
                    maxLines: 1,
                    softWrap: true,
                    style: const TextStyle().normalFontSize.extraBold,
                  ),
                  Text(
                    'أدريانا كرول',
                    maxLines: 1,
                    style: const TextStyle(color: AppColors.lightTextColor).middleFontSize.semiBold,
                  ),
                  const SizedBox(height: 5),
                ],
              ).paddingHorizontal(5),
            ),
          ],
        ),
      ),
    );
  }
}
