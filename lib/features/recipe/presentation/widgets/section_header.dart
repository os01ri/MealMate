import 'package:flutter/material.dart';

import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.showTrailing = true,
  });

  final String title;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.brown).largeFontSize.bold,
        ),
        if (showTrailing)
          Row(
            children: [
              Text(
                serviceLocator<LocalizationClass>().appLocalizations!.seeAll,
                style: const TextStyle(color: AppColors.mainColor).normalFontSize.bold,
              ),
              const Icon(Icons.arrow_forward, color: AppColors.mainColor),
            ],
          ).onTap(() => context.myPushNamed(RoutesNames.recipesViewAll))
        else
          const SizedBox.shrink(),
      ],
    ).paddingHorizontal(20);
  }
}
