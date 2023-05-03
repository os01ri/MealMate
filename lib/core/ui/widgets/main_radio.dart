import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';

class MainRadio extends StatelessWidget {
  const MainRadio({
    Key? key,
    this.style,
    required this.size,
    required this.value,
    required this.title,
    required this.onChanged,
    this.color,
  }) : super(key: key);

  final Size size;
  final bool value;
  final String title;
  final Color? color;
  final void Function(bool?) onChanged;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: true,
          groupValue: value,
          onChanged: onChanged,
          activeColor: color ?? AppColors.orange,
          overlayColor: MaterialStateProperty.all<Color>(
            AppColors.grey2,
          ),
        ),
        Text(
          title,
          style: style ?? AppTextStyles.styleWeight400(fontSize: size.width * .035),
        )
      ],
    );
  }
}
