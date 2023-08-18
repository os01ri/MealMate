import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/skelton_loading.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../cubit/recipe_cubit.dart';
import '../widgets/category_choice_chip.dart';
import '../widgets/floating_search_text_failed.dart';
import 'recipes_home_page.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  late final FloatingSearchBarController floatingSearchBarController;

  @override
  void initState() {
    super.initState();
    floatingSearchBarController = FloatingSearchBarController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit()
        ..indexRecipes(const IndexRecipesParams())
        ..indexTypes()
        ..indexCategories(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SearchBody(floatingSearchBarController: floatingSearchBarController),
            FloatingSearchTextFailed(floatingSearchBarController: floatingSearchBarController),
          ],
        ),
      ),
    );
  }
}

class SearchBody extends StatefulWidget {
  const SearchBody({super.key, required this.floatingSearchBarController});

  final FloatingSearchBarController floatingSearchBarController;

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  late final ValueNotifier<int> _selectedType;
  late final ValueNotifier<int> _selectedCat;

  @override
  void initState() {
    super.initState();
    _selectedType = ValueNotifier(0);
    _selectedCat = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: context.width * .16,
        leading: const SizedBox.square(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: AppConfig.animationDuration,
                child: switch (context.read<RecipeCubit>().state.indexTypesStatus) {
                  CubitStatus.loading => _buildTypesSkeltonLoading(),
                  CubitStatus.success => _buildTypesListView(context, state),
                  _ => MainErrorWidget(onTap: () => context.read<RecipeCubit>().indexTypes()).center(),
                },
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: AppConfig.animationDuration,
                child: switch (context.read<RecipeCubit>().state.indexCategoriesStatus) {
                  CubitStatus.loading => _buildTypesSkeltonLoading(),
                  CubitStatus.success => _buildCategoriesListView(context, state),
                  _ => MainErrorWidget(onTap: () => context.read<RecipeCubit>().indexCategories()).center(),
                },
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              if (state.indexRecipeStatus == CubitStatus.failure) {
                return MainErrorWidget(
                  onTap: () => context.read<RecipeCubit>().indexRecipes(const IndexRecipesParams()),
                ).center();
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: .8,
                ),
                itemCount: switch (state.indexRecipeStatus) {
                  CubitStatus.loading => 20,
                  CubitStatus.success => state.recipes.length,
                  _ => 0,
                },
                itemBuilder: (context, index) => AnimatedSwitcher(
                  duration: AppConfig.animationDuration,
                  child: switch (state.indexRecipeStatus) {
                    CubitStatus.loading => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
                          // width: context.width * .4,
                          // height: context.width * .4 / .8,
                        ),
                      ),
                    CubitStatus.success => RecipeCard(recipe: state.recipes[index]),
                    _ => const SizedBox.shrink(),
                  },
                ),
              );
            },
          ).expand(),
        ],
      ).padding(AppConfig.pagePadding),
    );
  }

  Widget _buildTypesSkeltonLoading() {
    return SizedBox(
      key: UniqueKey(),
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(end: 15),
        children: List.generate(
          6,
          (_) => const SkeltonLoading(
            height: 50,
            width: 110,
            margin: EdgeInsetsDirectional.only(start: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildTypesListView(BuildContext context, RecipeState state) {
    return SizedBox(
      height: 45,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedType,
        builder: (context, selectedTypeValue, child) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                    name: widget.floatingSearchBarController.query,
                    typeId: selectedTypeValue != 0 ? state.types[selectedTypeValue].id : null,
                    categoryId: _selectedCat.value != 0 ? state.categories[_selectedCat.value].id : null,
                  ));
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(end: 15),
              itemCount: context.read<RecipeCubit>().state.types.length,
              itemBuilder: (context, index) {
                return CategoryChoiceChip(
                  title: context.read<RecipeCubit>().state.types[index].name!,
                  isActive: index == selectedTypeValue,
                  onTap: () {
                    _selectedType.value = index;
                    context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                          name: widget.floatingSearchBarController.query,
                          typeId: index != 0 ? state.types[index].id : null,
                          categoryId: _selectedCat.value != 0 ? state.categories[_selectedCat.value].id : null,
                        ));
                  },
                );
              },
            ),
          );
        },
      ).paddingVertical(0),
    );
  }

  Widget _buildCategoriesListView(BuildContext context, RecipeState state) {
    return SizedBox(
      height: 45,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, selectedCatValue, child) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                    name: widget.floatingSearchBarController.query,
                    typeId: _selectedType.value != 0 ? state.types[_selectedType.value].id : null,
                    categoryId: selectedCatValue != 0 ? state.categories[selectedCatValue].id : null,
                  ));
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(end: 15),
              itemCount: context.read<RecipeCubit>().state.categories.length,
              itemBuilder: (context, index) {
                return CategoryChoiceChip(
                  title: context.read<RecipeCubit>().state.categories[index].name!,
                  isActive: index == selectedCatValue,
                  onTap: () {
                    _selectedCat.value = index;

                    context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                          name: widget.floatingSearchBarController.query,
                          typeId: _selectedType.value != 0 ? state.types[_selectedType.value].id : null,
                          categoryId: index != 0 ? state.categories[index].id : null,
                        ));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
