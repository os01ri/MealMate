import 'package:flutter/material.dart';

import '../../../recipe/presentation/widgets/app_bar.dart';

class AddRestrictionPage extends StatelessWidget {
  const AddRestrictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'إضافة استثناء',
      ),
    );
  }
}
