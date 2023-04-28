import 'package:flutter/material.dart';

class IntroImage extends StatelessWidget {
  final String urlImage;

  const IntroImage({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        width: 90.0,
        height: 40.0,
        child: Image.asset(urlImage),
      ),
    );
  }
}
