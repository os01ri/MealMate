import 'package:flutter/material.dart';
import 'package:mealmate/core/helper/app_config.dart';

class IntroIndicator extends StatelessWidget {
  final int pageNumber;
  final int index;
  final bool isCircle;
  const IntroIndicator(
      {Key? key,
      required this.index,
      required this.pageNumber,
      required this.isCircle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageNumber, (i) {
        return _dot(index == i ? true : false);
      }),
    );
  }

  _dot(bool active) { 
    const kCurves = Curves.linear;
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: isCircle
          ? AnimatedContainer(
              curve: kCurves,
              duration: AppConfig.pageViewAnimationDuration,
              height: active ? 15.0 : 10.0,
              width: active ? 15.0 : 10.0,
              decoration: BoxDecoration(
                border: active ? Border.all(color: Colors.white) : null,
                shape: BoxShape.circle,
              ),
              child: FractionallySizedBox(
                  heightFactor: .8,
                  widthFactor: .8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          active ? Colors.white : Colors.white.withAlpha(150),
                    ),
                  )),
            )
          : AnimatedContainer(
              curve: kCurves,
              duration: AppConfig.pageViewAnimationDuration,
              height: 1.0,
              width: active ? 9.7 : 5.5,
              color: Colors.white,
            ),
    );
  }
}
