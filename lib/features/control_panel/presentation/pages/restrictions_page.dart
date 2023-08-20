import 'package:flutter/material.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';

import '../../../../core/extensions/routing_extensions.dart';
import '../../../../router/routes_names.dart';

class RestrictionsPage extends StatelessWidget {
  const RestrictionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'الاستثناءات',
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.myPushNamed(RoutesNames.addRestriction),
      ),
    );
  }
}
