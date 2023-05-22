// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/main_text_field.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField(
      {super.key,
      this.controller,
      required this.hint,
      this.validator,
      required this.label,
      this.isPassword = false});
  final TextEditingController? controller;
  final String hint;
  final String label;
  final bool? isPassword;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.topLeft,
          child: Text(label, style: AppTextStyles.styleWeight500(fontSize: 16)),
        ),
        MainTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          fillColor: AppColors.scaffoldBackgroundColor,
          isPassword: !isPassword!,
          controller: controller ?? TextEditingController(),
          hint: hint,
          validator: validator,
        ),
      ],
    ).paddingVertical(5);
  }
}
