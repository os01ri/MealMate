part of '../pages/recipe_page.dart';

class _HeaderImage extends StatelessWidget {
  const _HeaderImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      PngPath.food2,
      fit: BoxFit.fitWidth,
      width: context.width,
    ).hero('picture');
  }
}
