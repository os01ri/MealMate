import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../data/models/index_ingredients_response_model.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({
    super.key,
    required this.ingredient,
    this.widgetKey,
  });

  final IngredientModel ingredient;
  final GlobalKey? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: context.width * .5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            key: widgetKey ?? GlobalKey(),
            child: CachedNetworkImage(
              hash: ingredient.hash ?? 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
              url: ingredient.url!,
              width: context.width * .5 - 65,
              height: context.width * .5 - 65,
            ),
          ),
          FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  width: context.width * .3,
                  child: Text(
                    ingredient.name!,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle().normal2FontSize.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: context.width * .3,
                  child: Text(
                    // '1 Kg => ${state.ingredients[index].price}\$',
                    '${ingredient.price} ل.س \nلـ ${ingredient.priceBy} كجم ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.lightTextColor).normalFontSize.bold,
                  ),
                ).center(),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
