// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    this.controller,
    required this.hint,
    this.validator,
    required this.label,
      this.isPassword = false,
      this.icon
  });

  final TextEditingController? controller;
  final String hint;
  final String label;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final IconData? icon;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final ValueNotifier<bool> showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = ValueNotifier(widget.isPassword!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          alignment: AlignmentDirectional.topStart,
          child: Text(widget.label, style: AppTextStyles.styleWeight500(fontSize: 16)),
        ),
        ValueListenableBuilder(
          valueListenable: showPassword,
          builder: (BuildContext context, bool show, Widget? child) {
            return MainTextField(
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: AppColors.orange,
                    )
                  : null,
              suffixIcon: widget.isPassword!
                  ? GestureDetector(
                      onTap: () {
                        showPassword.value = !show;
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: show
                            ? Icon(
                                Icons.visibility_off,
                                size: context.width * .05,
                                key: const Key("show"),
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                size: context.width * .05,
                                key: const Key("notShow"),
                              ),
                      ),
                    )
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              fillColor: AppColors.scaffoldBackgroundColor,
              isPassword: !show,
              controller: widget.controller ?? TextEditingController(),
              hint: widget.hint,
              validator: widget.validator,
            );
          },
        ),
      ],
    ).paddingVertical(5);
  }
}
