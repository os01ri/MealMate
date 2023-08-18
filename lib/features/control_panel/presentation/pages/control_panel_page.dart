import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({super.key});

  @override
  State<ControlPanelPage> createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with SingleTickerProviderStateMixin {
  static const _verticalSeparator = SizedBox(height: 20);
  static const _horizontalSeparator = SizedBox(width: 20);

  late final TabController tabController;
  late final ValueNotifier<int> index;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    index = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        centerText: true,
        leadingWidget: IconButton(
          icon: const Icon(Icons.storefront_outlined, color: AppColors.orange),
          onPressed: () => context.myPushNamed(RoutesNames.grocery),
        ),
        title: 'Control',
        actions: [
          IconButton(
            icon: const Icon(Icons.star_rounded, color: AppColors.orange),
            onPressed: () => context.myPushNamed(RoutesNames.favorite),
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppColors.orange),
            onPressed: () => context.myPushNamed(RoutesNames.settings),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _verticalSeparator,
          CachedNetworkImage(
            height: context.width * .3,
            width: context.width * .3,
            // margin: const EdgeInsets.all(5),
            // decoration: BoxDecoration(
            // color: Theme.of(context)
            //     .primaryColor
            //     .withOpacity(0.5),
            url:
                // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTs4XdD00sHtFKBYeyzKvz1CUHr598N0yrUA&usqp=CAU', //TODO
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZeAxmjEiBWqDFmnAq7cvlXRWq_WaaEBVyDolxUAZ0l-B9w4rAAotFfqIVWi1B9l6UBc&usqp=CAU', //TODO
            hash: 'LPODnIj[~qof-;fQM{fQoffQM{ay', //TODO
            shape: BoxShape.circle,
          ).center(),
          _verticalSeparator,
          const Text('Osama Rida'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '115${serviceLocator<LocalizationClass>().appLocalizations!.followers}'),
              _horizontalSeparator,
              Text(
                  '20 ${serviceLocator<LocalizationClass>().appLocalizations!.following}'),
            ],
          ),
          _verticalSeparator,
          ValueListenableBuilder(
            valueListenable: index,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Column(
                children: [
                  Row(
                    children: [
                      _Tab(
                        valueIndex: index,
                        tabController: tabController,
                        tabIndex: 0,
                        title: serviceLocator<LocalizationClass>()
                            .appLocalizations!
                            .recipes,
                      ),
                      _Tab(
                        valueIndex: index,
                        tabController: tabController,
                        tabIndex: 1,
                        title: serviceLocator<LocalizationClass>()
                            .appLocalizations!
                            .preferences,
                      ),
                    ],
                  ).paddingAll(20),
                  _verticalSeparator,
                  SizedBox(
                    height: context.height * .3,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Center(
                            child: Text(serviceLocator<LocalizationClass>()
                                .appLocalizations!
                                .youDidntMakePreferencesYet)),
                        Center(
                            child: Text(serviceLocator<LocalizationClass>()
                                .appLocalizations!
                                .youDidntPostRecipeYet)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ).padding(AppConfig.pagePadding),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
    required this.tabController,
    required this.valueIndex,
    required this.tabIndex,
  });

  final String title;
  final TabController tabController;
  final ValueNotifier<int> valueIndex;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      fontSize: 14,
      text: title,
      elevation: 0,
      textColor: valueIndex.value == tabIndex
          ? AppColors.scaffoldBackgroundColor
          : Colors.black,
      color: valueIndex.value == tabIndex
          ? AppColors.mainColor
          : AppColors.scaffoldBackgroundColor,
      onPressed: () {
        tabController.animateTo(valueIndex.value);
        valueIndex.value = tabIndex;
      },
    ).expand();
  }
}
