import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/features/control_panel/domain/usecases/remove_favorite_recipe_usecase.dart';

import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../core/ui/widgets/skelton_loading.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../recipe/presentation/pages/recipes_home_page.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../cubit/favorite_recipes_cubit/favorite_recipes_cubit.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteRecipesCubit>.value(
      value: serviceLocator<FavoriteRecipesCubit>()..indexFavoriteRecipes(),
      child: BlocListener<FavoriteRecipesCubit, FavoriteRecipesState>(
        bloc: serviceLocator<FavoriteRecipesCubit>(),
        listener: (context, state) {
          if (state.deleteStatus == CubitStatus.loading) {
            Toaster.showLoading();
          } else if (state.deleteStatus == CubitStatus.failure) {
            Toaster.closeLoading();
            Toaster.showToast('حدث خطأ، أعد المحاولة');
          } else if (state.deleteStatus == CubitStatus.success) {
            Toaster.closeLoading();
            Toaster.showToast('تم إزلة الوصفة من المفضلة');
            context.pop();
            serviceLocator<FavoriteRecipesCubit>().indexFavoriteRecipes();
          }
        },
        child: Scaffold(
          appBar: RecipeAppBar(
            context: context,
            centerText: true,
            title: 'Favorite',
          ),
          body: BlocBuilder<FavoriteRecipesCubit, FavoriteRecipesState>(
            builder: (context, state) {
              if (state.indexStatus == CubitStatus.failure) {
                return MainErrorWidget(
                  onTap: () => serviceLocator<FavoriteRecipesCubit>().indexFavoriteRecipes(),
                ).center();
              } else if (state.indexStatus == CubitStatus.success && state.favoriteRecipes.isEmpty) {
                return Text(
                  'لايوجد وصفات مفضلة بعد',
                  style: const TextStyle().largeFontSize,
                ).center();
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: .8,
                ),
                itemCount: switch (state.indexStatus) {
                  CubitStatus.loading => 20,
                  CubitStatus.success => state.favoriteRecipes.length,
                  _ => 0,
                },
                itemBuilder: (context, index) => AnimatedSwitcher(
                  duration: AppConfig.animationDuration,
                  child: switch (state.indexStatus) {
                    CubitStatus.loading => SkeltonLoading(
                        borderRadius: BorderRadius.circular(15),
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    CubitStatus.success => RecipeCard(
                        recipe: state.favoriteRecipes[index],
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) {
                            return SimpleDialog(
                              backgroundColor: Colors.white,
                              contentPadding: const EdgeInsets.all(30),
                              title: Text(state.favoriteRecipes[index].name!).center(),
                              shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
                              children: [
                                MainButton(
                                  text: 'عرض',
                                  color: AppColors.mainColor,
                                  onPressed: () {
                                    context.myPop();
                                    context.myPushNamed(RoutesNames.recipeIntro, extra: state.favoriteRecipes[index]);
                                  },
                                ),
                                const SizedBox(height: 20),
                                MainButton(
                                  text: 'إزالة من المفضلة',
                                  textColor: AppColors.brown,
                                  color: Colors.white,
                                  onPressed: () {
                                    context.read<FavoriteRecipesCubit>().removeFavoriteRecipe(
                                          RemoveFavoriteRecipeParams(id: state.favoriteRecipes[index].likedRecipe!.id!),
                                        );
                                  },
                                ),
                                const SizedBox(height: 20),
                                MainButton(
                                  text: 'إغلاق',
                                  textColor: AppColors.lightRed,
                                  color: Colors.white,
                                  onPressed: () => context.myPop(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    _ => const SizedBox.shrink(),
                  },
                ),
              );
            },
          ).padding(AppConfig.pagePadding).paddingVertical(10),
        ),
      ),
    );
  }
}
