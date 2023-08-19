import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../recipe/presentation/pages/recipes_home_page.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../cubit/control_panel_cubit/control_panel_cubit.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({super.key});

  @override
  State<ControlPanelPage> createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage> with SingleTickerProviderStateMixin {
  static const _verticalSeparator = SizedBox(height: 20);
  static const _horizontalSeparator = SizedBox(width: 20);

  late final TabController tabController;
  late final ValueNotifier<int> index;
  late ControlPanelCubit controlPanelCubit;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    index = ValueNotifier(0);
    controlPanelCubit = serviceLocator<ControlPanelCubit>()
      ..getUserInfo()
      ..indexMyRecipes();
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
        title: serviceLocator<LocalizationClass>().appLocalizations!.myProfile,
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
      body: BlocConsumer<ControlPanelCubit, ControlPanelState>(
        bloc: controlPanelCubit,
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state.getUserInfoStatus == CubitStatus.success
                  ? _UserDetailsWidget(
                      user: state.user!,
                      verticalSeparator: _verticalSeparator,
                      horizontalSeparator: _horizontalSeparator,
                    )
                  : SizedBox(
                      height: context.height * .3,
                      child: Center(
                        child: state.getUserInfoStatus == CubitStatus.failure
                            ? MainErrorWidget(
                                onTap: () {
                                  controlPanelCubit.getUserInfo();
                                },
                              )
                            : const CircularProgressIndicator.adaptive(),
                      ),
                    ),
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
                            onTap: () {
                              controlPanelCubit.indexMyRecipes();
                            },
                            tabIndex: 0,
                            title: serviceLocator<LocalizationClass>().appLocalizations!.recipes,
                          ),
                          _Tab(
                            valueIndex: index,
                            tabController: tabController,
                            tabIndex: 1,
                            title: serviceLocator<LocalizationClass>().appLocalizations!.preferences,
                          ),
                        ],
                      ).paddingAll(20),
                      _verticalSeparator,
                    ],
                  );
                },
              ),
              SizedBox(
                height: context.height * .35,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    state.recipesStatus == CubitStatus.success
                        ? state.recipes.isEmpty
                            ? Text(
                                serviceLocator<LocalizationClass>().appLocalizations!.youDidntPostRecipeYet,
                              ).center()
                            : SizedBox(
                                height: context.height * .3,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: .8,
                                  ),
                                  itemCount: state.recipes.length,
                                  itemBuilder: (context, index) => RecipeCard(recipe: state.recipes[index]),
                                ),
                              )
                        : Center(
                            child: state.recipesStatus == CubitStatus.failure
                                ? MainErrorWidget(onTap: () {
                                    controlPanelCubit.indexMyRecipes();
                                  })
                                : const CircularProgressIndicator.adaptive()),
                    Center(
                        child: Text(serviceLocator<LocalizationClass>().appLocalizations!.youDidntMakePreferencesYet)),
                  ],
                ),
              ),
            ],
          ).padding(AppConfig.pagePadding);
        },
      ),
    );
  }
}

class _UserDetailsWidget extends StatelessWidget {
  const _UserDetailsWidget({
    required this.user,
    required SizedBox verticalSeparator,
    required SizedBox horizontalSeparator,
  })  : _verticalSeparator = verticalSeparator,
        _horizontalSeparator = horizontalSeparator;

  final SizedBox _verticalSeparator;
  final SizedBox _horizontalSeparator;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _verticalSeparator,
      CachedNetworkImage(
        height: context.width * .3,
        width: context.width * .3,
        url: user.logo ?? SvgPath.defaultImage,
        hash: user.hash ?? SvgPath.defaultHash, //TODO
        shape: BoxShape.circle,
      ).center(),
      _verticalSeparator,
      Text(user.username ?? 'Osama Rida'),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${user.followers ?? 115} ${serviceLocator<LocalizationClass>().appLocalizations!.followers}'),
          _horizontalSeparator,
          Text('${user.following ?? 25} ${serviceLocator<LocalizationClass>().appLocalizations!.following}'),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.edit),
          Text(serviceLocator<LocalizationClass>().appLocalizations!.edit),
        ],
      ).onTap(() => context.myPushNamed(RoutesNames.editProfile)),
      _verticalSeparator,
    ]);
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
    required this.tabController,
    required this.valueIndex,
    this.onTap,
    required this.tabIndex,
  });

  final String title;
  final TabController tabController;
  final ValueNotifier<int> valueIndex;
  final int tabIndex;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      fontSize: 14,
      text: title,
      elevation: 0,
      textColor: valueIndex.value == tabIndex ? AppColors.scaffoldBackgroundColor : Colors.black,
      color: valueIndex.value == tabIndex ? AppColors.mainColor : AppColors.scaffoldBackgroundColor,
      onPressed: () {
        onTap?.call();
        valueIndex.value = tabIndex;
        tabController.animateTo(valueIndex.value);
      },
    ).expand();
  }
}
