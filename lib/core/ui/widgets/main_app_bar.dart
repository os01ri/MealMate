import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    Key? key,
    this.actionsWidget = const [],
    required this.size,
    required this.titleText,
    this.leadingWidget,
    this.backColor = Colors.white,
    this.foreColor = AppColors.orange,
    this.bottomWidget,
    this.fontSize,
    this.onTap,
  }) : super(
          key: key,
          backgroundColor: backColor,
          foregroundColor: foreColor,
          leading: leadingWidget,
          actions: actionsWidget,
          centerTitle: false,
          elevation: 0,
          toolbarHeight: size.width * .15,
          title: GestureDetector(
            onTap: onTap,
            child: Text(
              titleText,
              style: AppTextStyles.styleWeight600(
                fontSize: fontSize ?? size.width * .06,
                color: foreColor,
              ),
            ),
          ),
          bottom: bottomWidget,
        );

  final String titleText;
  final Color backColor;
  final Color foreColor;
  final List<Widget> actionsWidget;
  final Size size;
  final double? fontSize;
  final PreferredSizeWidget? bottomWidget;
  final Widget? leadingWidget;
  final VoidCallback? onTap;
}
