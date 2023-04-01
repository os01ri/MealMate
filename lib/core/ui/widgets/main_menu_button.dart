import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

import '../theme/text_styles.dart';

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({
    Key? key,
    required this.itemList,
    required this.title,
    required this.child,
    this.decoration,
    this.height = .9,
    this.onItemSelected,
    this.buttonColor,
    this.menuColor = Colors.white,
  }) : super(key: key);

  final List<String> itemList;
  final String title;
  final Widget child;
  final BoxDecoration? decoration;
  final double height;
  final Color? buttonColor;
  final Color menuColor;
  final void Function(String)? onItemSelected;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MenuButton<String>(
      itemBackgroundColor: Colors.grey.shade300,
      menuButtonBackgroundColor: buttonColor ?? Colors.transparent,
      decoration: decoration,
      items: itemList,
      popupHeight: itemList.length > 3 ? size.width * height : null,
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      onItemSelected: onItemSelected,
      toggledChild: Container(
        // width: size.width,
        // height: size.width * .125,
        color: menuColor,
        padding: EdgeInsetsDirectional.only(
          start: size.width * .04,
          end: size.width * .03,
          top: size.width * .025,
          bottom: size.width * .025,
        ),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleWeight500(
              color: Colors.grey.shade700,
              fontSize: size.width * .035,
            ),
          ),
        ),
      ),
      itemBuilder: (String value) => Container(
        decoration: BoxDecoration(
          color: menuColor,
        ),
        // height: size.width * .1,

        alignment: Alignment.centerRight,
        padding: EdgeInsetsDirectional.only(
          start: size.width * .01,
          top: size.width * .025,
          bottom: size.width * .025,
        ),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            value,
            style: AppTextStyles.styleWeight500(
              fontSize: size.width * .035,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
