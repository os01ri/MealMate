import 'package:flutter/material.dart';

class Slide extends StatelessWidget {
  final Widget image;
  final bool placeImage;
  const Slide({Key? key, required this.image, required this.placeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.2), shape: BoxShape.circle),
      child: Center(
        child: image,
      ),
    );
  }
}
