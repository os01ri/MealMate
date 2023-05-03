import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'main_button.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    Key? key,
    required this.size,
    required this.onTap,
    this.color = AppColors.orange,
    this.textColor,
  }) : super(key: key);

  final void Function() onTap;
  final Color color;
  final Color? textColor;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   SvgPath.networkError,
          //   width: size.width * .25,
          // ),
          SizedBox(height: size.width * .02),
          Text(
            'error',
            style: AppTextStyles.styleWeight500(
              color: Colors.grey.shade400,
              fontSize: size.width * .04,
            ),
          ),
          SizedBox(height: size.width * .02),
          SizedBox(
            height: size.width * .12,
            child: FittedBox(
              child: MainButton(
                width: size.width * .3,
                text: 'retry',
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
