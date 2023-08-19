// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/ui/toaster.dart';
import 'package:mealmate/features/control_panel/domain/usecases/add_favorite_recipe_usecase.dart';
import 'package:mealmate/features/control_panel/presentation/cubit/favorite_recipes_cubit/favorite_recipes_cubit.dart';
import 'package:mealmate/features/media_service/data/model/media_model.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_steps_page.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';
import '../cubit/recipe_cubit.dart';
import '../widgets/app_bar.dart';

part '../widgets/header_image.dart';
part '../widgets/recipe_budget_card.dart';
part '../widgets/recipe_tab_bar.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeCubit()..showRecipe(widget.id),
      child: BlocConsumer<RecipeCubit, RecipeState>(
        listener: (context, state) {
          log(state.showRecipeStatus.toString());
        },
        builder: (context, state) {
          return Scaffold(
            appBar: RecipeAppBar(
              context: context,
              title: state.showRecipeStatus == CubitStatus.success ? state.recipe!.name! : 'loading...',
              actions: [
                BlocListener<FavoriteRecipesCubit, FavoriteRecipesState>(
                  bloc: serviceLocator<FavoriteRecipesCubit>(),
                  listener: (context, state) {
                    if (state.addStatus == CubitStatus.loading) {
                      Toaster.showLoading();
                    } else if (state.addStatus == CubitStatus.failure) {
                      Toaster.closeLoading();
                      Toaster.showToast('حدث خطأ، أعد المحاولة');
                    } else if (state.addStatus == CubitStatus.success) {
                      Toaster.closeLoading();
                      Toaster.showToast('تم إضافة الوصفة للمفضلة');
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      serviceLocator<FavoriteRecipesCubit>().addFavoriteRecipe(AddFavoriteRecipeParams(
                        id: state.recipe!.id!,
                      ));
                    },
                    icon: Image.asset(
                      PngPath.saveInactive,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            body: state.showRecipeStatus == CubitStatus.success
                ? CustomScrollView(
                    dragStartBehavior: DragStartBehavior.down,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          _HeaderImage(state.recipe!.url!).paddingHorizontal(5),
                          _RecipeBudget(
                            duration: state.recipe!.time!,
                            persons: state.recipe!.feeds!,
                            price: state.recipe!.ingredients!
                                .map((e) => e.price)
                                .toList()
                                .fold(0, (previousValue, element) => previousValue + element!),
                            stepsCount: state.recipe!.steps!.length,
                          ).paddingVertical(8),
                          const _TabBar(),
                        ]),
                      ),
                      _IngredientList(ingredients: state.recipe!.ingredients!),
                    ],
                  ).padding(AppConfig.pagePadding)
                : const Center(child: CircularProgressIndicator.adaptive()),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: MainButton(
              color: AppColors.mainColor,
              onPressed: () {
                if (state.showRecipeStatus == CubitStatus.success) {
                  context.myPushNamed(
                    RoutesNames.recipeSteps,
                    extra: StepsScreenParams(
                      recipeId: state.recipe!.id!,
                      image: MediaModel(
                        mediaUrl: state.recipe!.url!,
                        hash: state.recipe!.hash!,
                      ),
                      steps: state.recipe!.steps!,
                    ),
                  );
                }
              },
              width: context.width,
              text: serviceLocator<LocalizationClass>().appLocalizations!.startCooking,
            ).hero('button').padding(AppConfig.pagePadding),
          );
        },
      ),
    );
  }
}

class _IngredientList extends StatelessWidget {
  final List<IngredientModel> ingredients;

  const _IngredientList({required this.ingredients});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: ingredients.length,
        (context, i) {
          for (var e in ingredients) {
            return Row(
              children: [
                Text(
                  e.name!,
                  style: const TextStyle().normalFontSize.semiBold,
                ),
                const Spacer(),
                Text(
                  ' ${e.recipeIngredient!.quantity!} ${e.unit!.name}',
                  style: const TextStyle(),
                ),
                Icon(
                  switch (i) {
                    <= 3 => Icons.check_circle_outline_rounded,
                    _ => Icons.warning_amber_rounded,
                  },
                  color: switch (i) {
                    <= 3 => Colors.green,
                    _ => Colors.red,
                  },
                ).paddingHorizontal(5),
              ],
            ).paddingAll(8);
          }
          return null;
        },
      ),
    );
  }
}
