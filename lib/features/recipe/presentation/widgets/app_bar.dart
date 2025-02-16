import 'package:flutter/material.dart';

import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/ui/font/typography.dart';

class RecipeAppBar extends AppBar {
  RecipeAppBar(
      {super.key,
      required BuildContext context,
      String? title,
      bool? centerText,
      Widget? leadingWidget,
      List<Widget>? actions,
      Color? color})
      : super(
          backgroundColor: color ?? Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: centerText ?? true,
          automaticallyImplyLeading: false,
          leadingWidth: leadingWidget == null ? 80 : 100,
          toolbarHeight: 80,
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle().xLargeFontSize.bold,
                )
              : const SizedBox.shrink(),
          leading: Row(
            children: [
              const SizedBox(width: 15),
              Card(
                elevation: 5,
                shape: const CircleBorder(),
                child: leadingWidget ??
                    IconButton(
                      style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
                      onPressed: () {
                        context.myPop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                      ).hero('arrow_back_ios_rounded'),
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
                // Card(
                //   elevation: 5,
                //   shape: const CircleBorder(),
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.more_horiz_rounded,
                //     ).hero('more_horiz_rounded'),
                //   ),
                // ).paddingHorizontal(15),
              ],
        );
}
