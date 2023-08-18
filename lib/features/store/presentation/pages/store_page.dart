import 'dart:developer';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/colorful_logging_extension.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart' as ext;
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/main_text_field.dart';
import '../../../../core/ui/widgets/skelton_loading.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../../recipe/presentation/widgets/category_choice_chip.dart';
import '../../domain/usecases/index_ingredients_categories_usecase.dart';
import '../../domain/usecases/index_ingredients_usecase.dart';
import '../cubit/cart_cubit/cart_cubit.dart';
import '../cubit/store_cubit/store_cubit.dart';
import '../widgets/ingredient_card.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final GlobalKey<CartIconKey> _cartKey;
  late final GlobalKey<CartIconKey> _wishlistKey;
  late final ValueNotifier<GlobalKey<CartIconKey>> _currentKey;
  late final ValueNotifier<int> _selectedCat;
  late final TextEditingController _searchController;
  late final Function(GlobalKey) _runAddToCartAnimation;

  @override
  void initState() {
    super.initState();
    _cartKey = GlobalKey<CartIconKey>();
    _searchController = TextEditingController();
    _wishlistKey = GlobalKey<CartIconKey>();
    _selectedCat = ValueNotifier(0);
    _currentKey = ValueNotifier(_cartKey);
  }

  void cartClick(GlobalKey widgetKey) async {
    await _runAddToCartAnimation(widgetKey);
    await _cartKey.currentState!.runCartAnimation();
  }

  void wishlistClick(GlobalKey widgetKey) async {
    await _runAddToCartAnimation(widgetKey);
    await _wishlistKey.currentState!.runCartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()
        ..getIngredients(const IndexIngredientsParams())
        ..getIngredientsCategories(const IndexIngredientsCategoriesParams()),
      child: ValueListenableBuilder<GlobalKey<CartIconKey>>(
        valueListenable: _currentKey,
        builder: (context, currentKeyValue, child) => AddToCartAnimation(
          cartKey: currentKeyValue,
          height: 30,
          width: 30,
          opacity: .9,
          dragAnimation: const DragToCartAnimationOptions(rotation: true, duration: Duration(milliseconds: 400)),
          jumpAnimation: const JumpAnimationOptions(active: false, duration: Duration(milliseconds: 150)),
          createAddToCartAnimation: (runAddToCartAnimation) => _runAddToCartAnimation = runAddToCartAnimation,
          child: child!,
        ),
        child: Scaffold(
          appBar: RecipeAppBar(
            context: context,
            centerText: true,
            title: serviceLocator<LocalizationClass>().appLocalizations!.groceryStore,
            leadingWidget: AddToCartIcon(
              key: _wishlistKey,
              badgeOptions: const BadgeOptions(active: false),
              icon: IconButton(
                onPressed: () {
                  context.myPushNamed(RoutesNames.wishListPage, extra: cartClick);
                },
                icon: Image.asset(
                  PngPath.saveInactive,
                  color: Colors.black,
                ),
              ),
            ),
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
                                decoration: const BoxDecoration(color: AppColors.mainColor, shape: BoxShape.circle),
                                child: Text(
                                  "${state.cartItems.length}",
                                  style: AppTextStyles.styleWeight400(color: Colors.white, fontSize: 16),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  AddToCartIcon(
                    key: _cartKey,
                    badgeOptions: const BadgeOptions(
                      active: false,
                    ),
                    icon: BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            if (state.ingredients.isNotEmpty) {
                              context.myPushNamed(
                                RoutesNames.cartPage,
                              );
                            }
                          },
                          icon: const Icon(Icons.shopping_bag_outlined),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              Builder(
                builder: (context) {
                  return MainTextField(
                    controller: _searchController,
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.searchIngredients,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          _searchController.clear();
                          context.read<StoreCubit>().getIngredients(const IndexIngredientsParams());
                        }
                      },
                    ),
                    onSubmitted: (searchTerm) {
                      if (searchTerm.isNotEmpty) {
                        context.read<StoreCubit>().getIngredients(IndexIngredientsParams(name: searchTerm));
                        _selectedCat.value = 0;
                      }
                    },
                    textInputAction: TextInputAction.search,
                  ).paddingVertical(5).padding(AppConfig.pagePadding);
                },
              ),
              BlocBuilder<StoreCubit, StoreState>(
                buildWhen: (previous, current) => previous.indexCategoriesStatus != current.indexCategoriesStatus,
                builder: (BuildContext context, StoreState state) {
                  return AnimatedSwitcher(
                    duration: AppConfig.animationDuration,
                    child: switch (state.indexCategoriesStatus) {
                      CubitStatus.loading => _buildCategoriesSkeltonLoading(),
                      CubitStatus.success => _buildCategoriesListView(context, state),
                      _ => MainErrorWidget(
                          onTap: () {
                            context
                                .read<StoreCubit>()
                                .getIngredientsCategories(const IndexIngredientsCategoriesParams());
                          },
                        ).center(),
                    },
                  );
                },
              ).paddingVertical(5),
              BlocBuilder<StoreCubit, StoreState>(
                buildWhen: (previous, current) => previous.indexStatus != current.indexStatus,
                builder: (BuildContext context, StoreState state) {
                  return AnimatedSwitcher(
                    duration: AppConfig.animationDuration,
                    child: switch (state.indexStatus) {
                      CubitStatus.loading => _buildIngredientsSkeltonLoading(),
                      CubitStatus.success => _buildIngredientsGridView(state),
                      _ => MainErrorWidget(
                          onTap: () {
                            context.read<StoreCubit>().getIngredients(IndexIngredientsParams(
                                  categoryId: _selectedCat.value != 0
                                      ? state.ingredientsCategories[_selectedCat.value].id
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
      ),
    );
  }

  Widget _buildCategoriesSkeltonLoading() {
    return SizedBox(
      key: UniqueKey(),
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(end: 15),
        children: List.generate(
          6,
          (index) => SkeltonLoading(
            height: 50,
            width: 110,
            // padding: 12,
            margin: EdgeInsetsDirectional.only(start: index == 0 ? 30 : 0, end: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesListView(BuildContext context, StoreState state) {
    return SizedBox(
      key: UniqueKey(),
      height: 45,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, value, child) {
          return SizedBox(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<StoreCubit>().getIngredients(IndexIngredientsParams(
                      categoryId: value != 0 ? state.ingredientsCategories[value].id : null,
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

                      context.read<StoreCubit>().getIngredients(IndexIngredientsParams(
                            categoryId: index != 0 ? state.ingredientsCategories[index].id : null,
                          ));
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
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
        ? const Text('لايوجد عناصر').center()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: .77,
            ),
            itemCount: state.ingredients.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  _currentKey.value = await context.myPushNamed<bool>(
                    RoutesNames.ingredient,
                    params: {'id': state.ingredients[index].id!.toString()},
                    extra: (cartClick, wishlistClick),
                  ).then((isCart) {
                    log(isCart.toString().logMagenta);
                    return switch (isCart) {
                      false => _wishlistKey,
                      _ => _cartKey,
                    };
                  });
                },
                child: IngredientCard(ingredient: state.ingredients[index]),
              );
            },
          );
  }
}
