import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart' as ext;
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/main_text_field.dart';
import '../../../../core/ui/widgets/skelton_loading.dart';
import '../../../../dependency_injection.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../../recipe/presentation/widgets/category_choice_chip.dart';
import '../../../store/domain/usecases/index_ingredients_categories_usecase.dart';
import '../../../store/domain/usecases/index_ingredients_usecase.dart';
import '../../../store/presentation/cubit/cart_cubit/cart_cubit.dart';
import '../../../store/presentation/cubit/store_cubit/store_cubit.dart';
import '../../../store/presentation/widgets/ingredient_card.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  late final ValueNotifier<int> _selectedCat;

  @override
  void initState() {
    super.initState();
    _selectedCat = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()
        ..getIngredients(const IndexIngredientsParams())
        ..getIngredientsCategories(const IndexIngredientsCategoriesParams()),
      child: Scaffold(
        appBar: RecipeAppBar(
          context: context,
          centerText: true,
          title: serviceLocator<LocalizationClass>()
              .appLocalizations!
              .groceryStore,
          actions: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    right: -5,
                    child: BlocBuilder<CartCubit, CartState>(
                      bloc: serviceLocator<CartCubit>(),
                      builder: (context, state) {
                        return state.cartItems.isNotEmpty
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle),
                                child: Text("${state.cartItems.length}",
                                    style: AppTextStyles.styleWeight400(
                                        color: Colors.white, fontSize: 16)),
                              )
                            : const SizedBox.shrink();
                      },
                    )),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Builder(builder: (context) {
              return MainTextField(
                controller: TextEditingController(),
                hint: serviceLocator<LocalizationClass>()
                    .appLocalizations!
                    .searchIngredients,
                prefixIcon: const Icon(Icons.search_rounded),
                onSubmitted: (searchTerm) {
                  context
                      .read<StoreCubit>()
                      .getIngredients(IndexIngredientsParams(name: searchTerm));
                  _selectedCat.value = 0;
                },
                textInputAction: TextInputAction.search,
              ).paddingVertical(5).padding(AppConfig.pagePadding);
            }),
            BlocBuilder<StoreCubit, StoreState>(
              buildWhen: (previous, current) =>
                  previous.indexCategoriesStatus !=
                  current.indexCategoriesStatus,
              builder: (BuildContext context, StoreState state) {
                return AnimatedSwitcher(
                  duration: AppConfig.animationDuration,
                  child: switch (state.indexCategoriesStatus) {
                    CubitStatus.success =>
                      _buildCategoriesListView(context, state),
                    _ => _buildCategoriesSkeltonLoading(),
                    // _ => const Text('error').center(),
                  },
                );
              },
            ).paddingVertical(5),
            BlocBuilder<StoreCubit, StoreState>(
              buildWhen: (previous, current) =>
                  previous.indexStatus != current.indexStatus,
              builder: (BuildContext context, StoreState state) {
                return AnimatedSwitcher(
                  duration: AppConfig.animationDuration,
                  child: switch (state.indexStatus) {
                    CubitStatus.loading => _buildIngredientsSkeltonLoading(),
                    CubitStatus.success => _buildIngredientsGridView(state),
                    _ => MainErrorWidget(
                        onTap: () {
                          context
                              .read<StoreCubit>()
                              .getIngredients(IndexIngredientsParams(
                                categoryId: _selectedCat.value != 0
                                    ? state
                                        .ingredientsCategories[
                                            _selectedCat.value]
                                        .id
                                    : null,
                              ));
                        },
                      ).center(),
                  },
                );
              },
            ).padding(AppConfig.pagePadding).expand(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSkeltonLoading() {
    return SizedBox(
      key: UniqueKey(),
      height: 75,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(end: 15),
        children: List.generate(
          6,
          (_) => const SkeltonLoading(
            height: 50,
            width: 100,
            padding: 12,
            margin: EdgeInsetsDirectional.only(start: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesListView(BuildContext context, StoreState state) {
    return SizedBox(
      key: UniqueKey(),
      height: 75,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, value, child) {
          return SizedBox(
            child: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<StoreCubit>()
                    .getIngredients(IndexIngredientsParams(
                      categoryId: value != 0
                          ? state.ingredientsCategories[value].id
                          : null,
                    ));
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsetsDirectional.only(end: 15),
                itemCount: state.ingredientsCategories.length,
                itemBuilder: (context, index) {
                  return CategoryChoiceChip(
                    title: state.ingredientsCategories[index].name!,
                    isActive: index == value,
                    onTap: () {
                      _selectedCat.value = index;

                      context
                          .read<StoreCubit>()
                          .getIngredients(IndexIngredientsParams(
                            categoryId: index != 0
                                ? state.ingredientsCategories[index].id
                                : null,
                          ));
                    },
                  );
                },
              ),
            ),
          );
        },
      ).paddingVertical(10),
    );
  }

  Widget _buildIngredientsSkeltonLoading() {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: .75,
      ),
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        6,
        (_) => SkeltonLoading(
          height: context.height,
          width: context.width,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildIngredientsGridView(StoreState state) {
    return (state.ingredients.isEmpty)
        ? Text(serviceLocator<LocalizationClass>()
                .appLocalizations!
                .noIngredients)
            .center()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: .75,
            ),
            itemCount: state.ingredients.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {},
                child: IngredientCard(
                  ingredient: state.ingredients[index],
                ),
              );
            },
          );
  }
}
