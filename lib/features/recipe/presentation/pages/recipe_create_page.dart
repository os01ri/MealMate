import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';

class RecipeCreatePage extends StatelessWidget {
  const RecipeCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create recipe',
              style: const TextStyle().xLargeFontSize.bold,
            ).paddingVertical(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                PngPath.food,
                fit: BoxFit.fitWidth,
                width: context.width,
              ).hero('picture'),
            ).paddingVertical(5),
            MainTextField(
              controller: TextEditingController(),
            ).paddingVertical(5),
            const _DetailCard(
              title: 'Serves',
              value: '01',
              icon: Icon(Icons.arrow_forward_rounded),
            ).paddingVertical(5),
            const _DetailCard(
              title: 'Time',
              value: '45 min',
              icon: Icon(Icons.arrow_forward_rounded),
            ).paddingVertical(5),
            Text(
              'Ingredients',
              style: const TextStyle().largeFontSize.bold,
            ).paddingVertical(10),
            ...List.generate(2, (index) => const _Ingredient().paddingAll(5)),
            Text(
              '+ Add New Ingredient',
              style: const TextStyle().normalFontSize.extraBold,
            ).paddingVertical(10),
          ],
        ).paddingHorizontal(15),
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  const _Ingredient();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MainTextField(
          controller: TextEditingController(),
        ).expand(flex: 2),
        MainTextField(
          controller: TextEditingController(),
        ).paddingHorizontal(20).expand(flex: 2),
        Container(
          width: context.width * .06,
          height: context.width * .06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: const Center(child: FittedBox(child: Icon(Icons.remove))),
        ).paddingAll(10),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: const Icon(
                Icons.people_alt,
                color: AppColors.buttonColor,
              ).paddingAll(5),
            ).paddingAll(12),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle().normalFontSize.bold,
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.lightTextColor,
              ),
            ),
            icon.paddingHorizontal(8),
          ],
        ),
      ),
    );
  }
}
