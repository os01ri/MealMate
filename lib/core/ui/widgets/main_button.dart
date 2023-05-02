import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';

import '../theme/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.text,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.shadowColor,
    this.icon,
    required this.color,
    required this.onPressed,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shadowColor: shadowColor != null ? MaterialStateProperty.all(shadowColor) : null,
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(
            width ?? context.width * .3,
            height ?? context.width * .11,
          ),
        ),
      ),
      onPressed: (onPressed != null)
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed!();
            }
          : null,
      child: FittedBox(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.styleWeight500(
                color: textColor,
                fontSize: fontSize ?? context.width * .0475,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 10),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
