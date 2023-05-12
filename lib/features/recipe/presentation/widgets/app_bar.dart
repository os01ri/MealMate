import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/font/typography.dart';

class RecipeAppBar extends AppBar {
  RecipeAppBar({
    super.key,
    required BuildContext context,
    String? title,
    Widget? leadingWidget,
    List<Widget>? actions,
  }) : super(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          toolbarHeight: 80,
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle().xLargeFontSize.bold,
                )
              : const SizedBox.shrink(),
          leading: leadingWidget ??
              Row(
                children: [
                  const SizedBox(width: 15),
                  Card(
                    elevation: 5,
                    shape: const CircleBorder(),
                    child: leadingWidget ??
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ).hero('arrow_back_ios_new_rounded'),
                        ),
                  ),
                ],
              ),
          actions: actions
                  ?.map(
                    (e) => Row(
                      children: [
                        Card(
                          elevation: 5,
                          shape: const CircleBorder(),
                          child: e,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  )
                  .toList() ??
              [
                Card(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                    ).hero('more_horiz_rounded'),
                  ),
                ).paddingHorizontal(15),
              ],
        );
}
