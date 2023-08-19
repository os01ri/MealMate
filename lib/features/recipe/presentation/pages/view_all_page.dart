import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

import '../../data/models/recipe_model.dart';
import '../widgets/app_bar.dart';
import 'recipes_home_page.dart';

class RecipeViewAllPage extends StatelessWidget {
  const RecipeViewAllPage({super.key, required this.recipes});

  final List<RecipeModel> recipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(context: context),
      body: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, index) {
          return RecipeCard(recipe: recipes[index]);
        },
      ).paddingAll(15),
    );
  }
}
