import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';

class RecipeAppBar extends AppBar {
  RecipeAppBar({
    super.key,
    required BuildContext context,
  }) : super(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz_rounded,
              ),
            ),
          ],
        );
}
