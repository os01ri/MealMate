import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/dependency_injection.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'main_button.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    Key? key,
    required this.onTap,
    this.color = AppColors.orange,
    this.textColor,
  }) : super(key: key);

  final void Function() onTap;
  final Color color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   SvgPath.networkError,
          //   width: size.width * .25,
          // ),
          SizedBox(height: context.width * .02),
          Text(
            serviceLocator<LocalizationClass>().appLocalizations!.error,
            style: AppTextStyles.styleWeight500(
              color: Colors.grey.shade400,
              fontSize: context.width * .04,
            ),
          ),
          SizedBox(height: context.width * .02),
          SizedBox(
            height: context.width * .12,
            child: FittedBox(
              child: MainButton(
                width: context.width * .3,
                text: serviceLocator<LocalizationClass>().appLocalizations!.retry,
                textColor: textColor ?? Colors.white,
                color: color,
                onPressed: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
