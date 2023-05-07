import 'package:flutter/material.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/main_text_field.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key, required this.hint, this.padding, required this.label});

  final String hint;
  final String label;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.topLeft,
            child: Text(
              label,
            ),
          ),
          MainTextField(
            fillColor: AppColors.scaffoldBackgroundColor,
            controller: TextEditingController(),
            hint: hint,
          ),
        ],
      ),
    );
  }
}
