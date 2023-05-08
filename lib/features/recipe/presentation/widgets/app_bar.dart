import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

class RecipeAppBar extends AppBar {
  RecipeAppBar({
    super.key,
    Widget? leadingWidget,
    required BuildContext context,
  }) : super(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: leadingWidget ??
              IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ).hero('arrow_back_ios_new_rounded'),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz_rounded,
              ).hero('more_horiz_rounded'),
            ),
          ],
        );
}
