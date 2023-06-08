part of '../pages/shell_page.dart';

class _CreateRecipeFAB extends StatelessWidget {
  const _CreateRecipeFAB();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.mainColor,
            AppColors.lightOrange,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: FloatingActionButton(
        elevation: .0,
        highlightElevation: .0,
        splashColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ).paddingAll(12.0),
        onPressed: () {
          context.pushNamed(RoutesNames.recipeCreate);
        },
      ),
    );
  }
}
