import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:shimmer/shimmer.dart';

class SkeltonLoading extends StatelessWidget {
  const SkeltonLoading({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
    this.padding = 0,
    this.margin,
  });

  final double height;
  final double width;
  final double padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffcbcbcb).withOpacity(0.4),
      highlightColor: const Color(0xffcbcbcb).withOpacity(0.6),
      child: Container(
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(25),
          border: Border.all(color: Colors.black12),
        ),
      ),
    ).paddingVertical(padding);
  }
}
