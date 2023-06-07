part of '../pages/recipe_details_page.dart';

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return _DetailCardRow(
      margin: const EdgeInsets.all(10),
      children: [
        const _Tab(title: 'المكونات', isActive: true).expand(),
        const SizedBox(width: 10),
        _Tab(
          title: serviceLocator<LocalizationClass>().appLocalizations!.nutritionalInfo,
          isActive: false,
        ).expand(),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.title, required this.isActive});

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppConfig.borderRadius,
        color: isActive ? AppColors.mainColor : Colors.white,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.lightTextColor,
          ).extraBold.normalFontSize,
        ).paddingAll(12),
      ),
    );
  }
}
