import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/cache_network_image.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';

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
              hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
              url: ingredient.url!,
              width: context.width * .5 - 65,
              height: context.width * .5 - 65,
            ),
          ),
          FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  width: context.width * .3,
                  child: Text(
                    ingredient.name!,
                    softWrap: true,
                    style: const TextStyle().normal2FontSize.bold,
                  ),
                ),
                SizedBox(
                  width: context.width * .3,
                  child: Text(
                    // '1 Kg => ${state.ingredients[index].price}\$',
                    '${ingredient.priceBy} كجم => ${ingredient.price} ل.س',
                    style: const TextStyle(color: AppColors.lightTextColor).middleFontSize.semiBold,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
