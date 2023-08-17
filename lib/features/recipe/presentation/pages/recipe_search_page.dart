import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipes_home_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../cubit/recipe_cubit.dart';
import '../widgets/category_choice_chip.dart';
import '../widgets/floating_search_text_failed.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> with TickerProviderStateMixin {
  late FloatingSearchBarController floatingSearchBarController;

  @override
  void initState() {
    floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit()..indexRecipes(const IndexRecipesParams()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SearchBody(),
            FloatingSearchTextFailed(floatingSearchBarController: floatingSearchBarController),
          ],
        ),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  SearchBody({super.key});

  final ValueNotifier<int> _selectedCat = ValueNotifier(0);

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
          _buildCategoriesListView(context),
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

  Widget _buildCategoriesListView(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, value, child) {
          return RefreshIndicator(
            onRefresh: () async {
              // context.read<StoreCubit>().getIngredients(IndexIngredientsParams(
              //       categoryId: value != 0 ? state.ingredientsCategories[value].id : null,
              //     ));
            },
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(end: 15),
              children: [
                CategoryChoiceChip(
                  title: 'الكـل',
                  isActive: 0 == value,
                  onTap: () {
                    _selectedCat.value = 0;
                  },
                ),
                CategoryChoiceChip(
                  title: 'الإفطار',
                  isActive: 1 == value,
                  onTap: () {
                    _selectedCat.value = 1;
                  },
                ),
                CategoryChoiceChip(
                  title: 'الغداء',
                  isActive: 2 == value,
                  onTap: () {
                    _selectedCat.value = 2;
                  },
                ),
                CategoryChoiceChip(
                  title: 'العشاء',
                  isActive: 3 == value,
                  onTap: () {
                    _selectedCat.value = 3;
                  },
                ),
              ],
            ),
          );
        },
      ).paddingVertical(10),
    );
  }
}
