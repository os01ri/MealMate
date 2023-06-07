import 'package:flutter/material.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';

class CategoryChoiceChip extends StatelessWidget {
  const CategoryChoiceChip({
    super.key,
    required this.isActive,
    required this.title,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsetsDirectional.only(start: 20),
      decoration: BoxDecoration(
        color: isActive ? AppColors.mainColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Icon(Icons.balance_rounded, color: AppColors.brown),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(color: AppColors.brown).normalFontSize,
          ),
        ],
      ),
    );
  }
}
