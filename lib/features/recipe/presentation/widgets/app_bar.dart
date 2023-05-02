part of '../pages/recipe_page.dart';

class _AppBar extends AppBar {
  _AppBar()
      : super(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz_rounded,
              ),
            ),
          ],
        );
}
