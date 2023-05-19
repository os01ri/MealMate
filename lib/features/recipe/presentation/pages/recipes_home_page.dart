import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

class RecipesHomePage extends StatelessWidget {
  const RecipesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: RecipeAppBar(context: context, leadingWidget: const SizedBox.shrink()),
      body: Stack(
        children: [
          const _UpperWidget().positioned(top: 0),
          const _BodyWidget().positioned(bottom: 0),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .5,
      width: context.width,
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Categories'),
          const SizedBox(height: 15),
          Row(
            children: [
              const CategoryChoiceChip(title: 'Breakfast', isActive: true),
              for (int i = 0; i < 10; i++) const CategoryChoiceChip(title: 'Dinner', isActive: false),
            ],
          ).scrollable(scrollDirection: Axis.horizontal),
          const SizedBox(height: 25),
          const SectionHeader(title: 'Recommended'),
          const SizedBox(height: 15),
          SizedBox(
            height: context.height * .25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10,
                (index) => FittedBox(
                  fit: BoxFit.fitHeight,
                  child: GestureDetector(
                    onTap: () {
                      context.push(Routes.recipeIntro);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            PngPath.food,
                            fit: BoxFit.fitWidth,
                            width: context.width,
                          ).hero(index == 0 ? 'picture' : '$index'),
                          FittedBox(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: context.width * .3,
                                  child: Text(
                                    'Indonesian chicken burger',
                                    softWrap: true,
                                    style: const TextStyle().normalFontSize.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * .3,
                                  child: Text(
                                    'By Adrianna Curl',
                                    style: const TextStyle(color: AppColors.lightTextColor).smallFontSize.semiBold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).paddingHorizontal(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ).scrollable().paddingAll(30),
    );
  }
}

class _UpperWidget extends StatelessWidget {
  const _UpperWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .6,
      width: context.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            AppColors.orange,
            AppColors.lightOrange,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Hello Osama!',
            style: const TextStyle(color: Colors.white).semiBold.largeFontSize,
          ),
          Text(
            'What would you like to cook today?',
            style: const TextStyle(color: Colors.white).bold.xxLargeFontSize,
          ),
          MainTextField(
            controller: TextEditingController(),
            hint: 'Search Recipes',
            prefixIcon: const Icon(Icons.search_rounded),
            borderRadius: BorderRadius.circular(25),
            suffixIcon: const Icon(
              Icons.filter_alt,
              color: Colors.white,
            ),
          ).paddingVertical(15),
          SizedBox(height: context.height * .05),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.brown).largeFontSize.bold,
        ),
        Row(
          children: [
            Text(
              'see all ',
              style: const TextStyle(color: AppColors.mainColor).normalFontSize.bold,
            ),
            const Icon(Icons.arrow_forward, color: AppColors.mainColor),
          ],
        ),
      ],
    );
  }
}

class CategoryChoiceChip extends StatelessWidget {
  const CategoryChoiceChip({
    super.key,
    required this.isActive,
    required this.title,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsetsDirectional.only(end: 15),
      decoration: BoxDecoration(
        color: isActive ? AppColors.mainColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Icon(Icons.balance_rounded),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(color: AppColors.brown).normalFontSize,
          ),
        ],
      ),
    );
  }
}

// class _NewWidget extends StatelessWidget {
//   const _NewWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             MainTextField(
//               controller: TextEditingController(),
//               hint: 'Search Recipes',
//               prefixIcon: const Icon(Icons.search_rounded),
//             ).paddingVertical(15).expand(),
//             Container(
//               decoration: BoxDecoration(
//                 color: AppColors.mainColor,
//                 borderRadius: AppConfig.borderRadius,
//               ),
//               width: context.width * .1,
//               height: context.width * .1,
//               child: const Icon(
//                 Icons.filter_alt,
//                 color: Colors.white,
//               ),
//             ).paddingHorizontal(5),
//           ],
//         ),
//         SizedBox(
//           height: context.height * .25,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: List.generate(
//               10,
//               (index) => FittedBox(
//                 fit: BoxFit.fitHeight,
//                 child: GestureDetector(
//                   onTap: () {
//                     context.push(Routes.recipeIntro);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGrey,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           PngPath.food,
//                           fit: BoxFit.fitWidth,
//                           width: context.width,
//                         ).hero(index == 0 ? 'picture' : '$index'),
//                         FittedBox(
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 10),
//                               SizedBox(
//                                 width: context.width * .3,
//                                 child: Text(
//                                   'Indonesian chicken burger',
//                                   softWrap: true,
//                                   style: const TextStyle().normalFontSize.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: context.width * .3,
//                                 child: Text(
//                                   'By Adrianna Curl',
//                                   style: const TextStyle(color: AppColors.lightTextColor).smallFontSize.semiBold,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ).paddingHorizontal(8),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
