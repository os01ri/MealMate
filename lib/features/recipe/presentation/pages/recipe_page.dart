import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';

part '../widgets/header_image.dart';
part '../widgets/recipe_details.dart';
part '../views/recipe_ingredients_view.dart';
part '../views/recipe_steps_view.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RecipeAppBar(context: context),
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const _HeaderImage().positioned(top: 0),
          const _RecipeDetails().positioned(bottom: 0),
        ],
      ),
    );
  }
}

// class MainButton extends StatelessWidget {
//   const MainButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: () {},
//       color: AppColors.purple,
//       minWidth: context.width * .95,
//       textColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: const Text('Start Coocking!'),
//     );
//   }
// }






 
