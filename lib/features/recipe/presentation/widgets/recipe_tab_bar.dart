part of '../pages/recipe_details_page.dart';

class _TabBar extends StatelessWidget {
  const _TabBar({required this.controller, required this.selectedIndex});
  final TabController controller;
  final ValueNotifier<int> selectedIndex;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, value, _) {
          return _DetailCardRow(
            margin: const EdgeInsets.all(10),
            children: [
              _Tab(
                      title: serviceLocator<LocalizationClass>()
                          .appLocalizations!
                          .ingredients,
                      onTap: () {
                        print(value);
                        selectedIndex.value = 0;
                        controller.animateTo(0);
                      },
                      isActive: value == 0)
                  .expand(),
              const SizedBox(width: 10),
              _Tab(
                title: serviceLocator<LocalizationClass>()
                    .appLocalizations!
                    .nutritionalInfo,
                onTap: () {
                  print(value);

                  selectedIndex.value = 1;

                  controller.animateTo(1);
                },
                isActive: value == 1,
              ).expand(),
            ],
          );
        });
  }
}

class _Tab extends StatelessWidget {
  const _Tab(
      {required this.title, required this.isActive, required this.onTap});

  final String title;
  final bool isActive;
  final VoidCallback onTap;
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
      ).onTap(() => onTap.call()),
    );
  }
}
