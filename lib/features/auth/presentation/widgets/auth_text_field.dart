// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/main_text_field.dart';

class AuthTextField extends StatefulWidget {
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
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final ValueNotifier<bool> showPassword;
  @override
  void initState() {
    showPassword = ValueNotifier(widget.isPassword!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container( 
          padding: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.topLeft,
          child: Text(widget.label,
              style: AppTextStyles.styleWeight500(fontSize: 16)),
        ),
        ValueListenableBuilder(
          valueListenable: showPassword,
          builder: (BuildContext context, bool show, Widget? child) {
            return MainTextField(
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
