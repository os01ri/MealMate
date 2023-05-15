part of '../pages/ingredient_page.dart';

class _HeaderImage extends StatelessWidget {
  const _HeaderImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      PngPath.tomato,
      fit: BoxFit.fitWidth,
      width: context.width,
    ).hero('picture');
  }
}
