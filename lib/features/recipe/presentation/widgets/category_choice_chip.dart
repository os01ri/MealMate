import 'package:flutter/material.dart';

import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';

class CategoryChoiceChip extends StatelessWidget {
  const CategoryChoiceChip({
    super.key,
    required this.isActive,
    required this.title,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      margin: const EdgeInsetsDirectional.only(start: 15),
      decoration: BoxDecoration(
        color: isActive ? AppColors.mainColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          // const Icon(Icons.balance_rounded, color: AppColors.brown),
          // const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(color: AppColors.brown).normalFontSize,
          ),
        ],
      ),
    ).onTap(onTap);
  }
}
