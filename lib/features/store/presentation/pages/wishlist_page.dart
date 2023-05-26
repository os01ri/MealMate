import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/presentation/pages/store_page.dart';
import 'package:mealmate/router/app_routes.dart';

class WishlistPage extends StatelessWidget {

  const WishlistPage({
    super.key,
    required this.onAddToCart,
  });

  final void Function(GlobalKey) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'Wishlist',
      ),
      body: Padding(
        padding: AppConfig.pagePadding.copyWith(top: 20),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: .85,
          ),
          scrollDirection: Axis.vertical,
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () async {
                context.push(
                  Routes.ingredientPage,
                  extra: (onAddToCart, onAddToCart),
                );
              },
              child: IngredientCard(
                index: index,
                title: 'بندورة',
              ).paddingHorizontal(0),
            ),
          ),
        ),
      ),
    );
  }
}
