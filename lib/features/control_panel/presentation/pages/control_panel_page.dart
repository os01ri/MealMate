import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/widgets/skelton_loading.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/error_widget.dart';
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
  late ControlPanelCubit controlPanelCubit;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    controlPanelCubit = serviceLocator<ControlPanelCubit>()
      ..indexMyRecipes()
      ..indexFollowers();
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
              SizedBox(
                height: context.height * .4,
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
        height: context.width * .35,
        width: context.width * .35,
        url: user.logo ?? SvgPath.defaultImage,
        hash: user.hash ?? SvgPath.defaultHash, //TODO
        shape: BoxShape.circle,
      ).center(),
      _verticalSeparator,
      Text(user.name ?? 'أسامة رضا', style: const TextStyle().bold.largeFontSize),
      BlocBuilder<ControlPanelCubit, ControlPanelState>(
        bloc: serviceLocator<ControlPanelCubit>(),
        builder: (context, state) {
          if (state.followersStatus == CubitStatus.loading) {
            return SkeltonLoading(height: 20, width: context.width * .4).center();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${state.followers.length} ${serviceLocator<LocalizationClass>().appLocalizations!.followers}',
                style: const TextStyle().semiBold.normalFontSize,
              ),
              _horizontalSeparator,
              Text(
                '${state.followings.length} ${serviceLocator<LocalizationClass>().appLocalizations!.following}',
                style: const TextStyle().semiBold.normalFontSize,
              ),
            ],
          );
        },
      ).paddingVertical(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.edit),
          Text(serviceLocator<LocalizationClass>().appLocalizations!.edit),
        ],
      ).onTap(() => context.myPushNamed(RoutesNames.editProfile)).center(),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.edit),
          Text(serviceLocator<LocalizationClass>().appLocalizations!.myRestrictions),
        ],
      ).onTap(() => context.myPushNamed(RoutesNames.restrictions)).center(),
    ]);
  }
}
