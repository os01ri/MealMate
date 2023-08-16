import 'package:flutter/material.dart';

import '../../data/models/recipe_model.dart';
import '../widgets/app_bar.dart';
import 'recipes_home_page.dart';

class RecipeViewAllPage extends StatelessWidget {
  const RecipeViewAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(context: context),
      body: GridView.builder(
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return RecipeCard(recipe: RecipeModel(url: '', name: ''));
        },
      ),
    );
  }
}
