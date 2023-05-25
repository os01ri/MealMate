part of '../pages/ingredient_page.dart';

class _HeaderImage extends StatelessWidget {
  _HeaderImage({required this.onAddToCart});

  final GlobalKey widgetKey = GlobalKey();
  final void Function(GlobalKey) onAddToCart;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widgetKey,
      child: Image.asset(
        PngPath.tomato,
        fit: BoxFit.fitWidth,
        width: context.width,
      ).hero('picture'),
    );
  }
}
