part of '../pages/recipe_details_page.dart';

class _HeaderImage extends StatelessWidget {
  const _HeaderImage(this.url);
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      url: url,
      fit: BoxFit.fitWidth,
      height: context.height * .25,
      borderRadius: BorderRadius.circular(10),
      width: context.width,
    ).hero('picture');
  }
}
