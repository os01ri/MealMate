import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/recipe/presentation/widgets/category_choice_chip.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients_usecase.dart';
import 'package:mealmate/features/store/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:mealmate/features/store/presentation/cubit/store_cubit/store_cubit.dart';
import 'package:mealmate/features/store/presentation/widgets/ingredient_card.dart';
import 'package:mealmate/router/routes_names.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final StoreCubit _storeCubit;
  late final GlobalKey<CartIconKey> _cartKey;
  late final GlobalKey<CartIconKey> _wishlistKey;
  late final ValueNotifier<GlobalKey<CartIconKey>> _currentKey;

  late Function(GlobalKey) _runAddToCartAnimation;

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit()..getIngredients(const IndexIngredientsParams());
    _cartKey = GlobalKey<CartIconKey>();
    _wishlistKey = GlobalKey<CartIconKey>();

    _currentKey = ValueNotifier(_cartKey);
  }

  void cartClick(GlobalKey widgetKey) async {
    await _runAddToCartAnimation(widgetKey);
    await _cartKey.currentState!.runCartAnimation();
    await _cartKey.currentState!.updateBadge(serviceLocator<CartCubit>().state.cartItems.length.toString());
  }

  void wishlistClick(GlobalKey widgetKey) async {
    await _runAddToCartAnimation(widgetKey);
    await _wishlistKey.currentState!.runCartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _storeCubit,
      child: ValueListenableBuilder<GlobalKey<CartIconKey>>(
        valueListenable: _currentKey,
        builder: (context, currentKeyValue, child) {
          return AddToCartAnimation(
            cartKey: currentKeyValue,
            height: 30,
            width: 30,
            opacity: .9,
            dragAnimation: const DragToCartAnimationOptions(rotation: true, duration: Duration(milliseconds: 400)),
            jumpAnimation: const JumpAnimationOptions(active: false, duration: Duration(milliseconds: 150)),
            createAddToCartAnimation: (runAddToCartAnimation) => _runAddToCartAnimation = runAddToCartAnimation,
            child: child!,
          );
        },
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
                  context.pushNamed(RoutesNames.wishListPage, extra: cartClick);
                },
                icon: Image.asset(
                  PngPath.saveInactive,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              AddToCartIcon(
                key: _cartKey,
                badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                icon: BlocBuilder<StoreCubit, StoreState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        if (state.ingredients.isNotEmpty) {
                          context.pushNamed(
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
          body: Column(
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  MainTextField(
                    controller: TextEditingController(),
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.searchIngredients,
                    prefixIcon: const Icon(Icons.search_rounded),
                    onSubmitted: (searchTerm) {},
                    textInputAction: TextInputAction.search,
                    // suffixIcon: InkWell(
                    //   onTap: () {},
                    //   child: const Icon(Icons.filter_alt),
                    // ),
                  ).paddingVertical(5).expand(),
                ],
              ).padding(AppConfig.pagePadding),
              Row(
                children: [
                  CategoryChoiceChip(
                    title: serviceLocator<LocalizationClass>().appLocalizations!.all,
                    isActive: true,
                  ),
                  for (int i = 0; i < 10; i++) const CategoryChoiceChip(title: 'خضار', isActive: false),
                ],
              ).scrollable(scrollDirection: Axis.horizontal).paddingVertical(10),
              const SizedBox(height: 5),
              BlocBuilder<StoreCubit, StoreState>(
                bloc: _storeCubit,
                builder: (BuildContext context, StoreState state) {
                  return switch (state.indexStatus) {
                    CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
                    CubitStatus.success => (state.ingredients.isEmpty)
                        ? const SizedBox.shrink()
                        : GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: .85,
                            ),
                            scrollDirection: Axis.vertical,
                            children: List.generate(
                              state.ingredients.length,
                              (index) => GestureDetector(
                                onTap: () async {
                                  _currentKey.value = await context.pushNamed<bool>(
                                    RoutesNames.ingredient,
                                    params: {'id': state.ingredients[index].id!},
                                    extra: (cartClick, wishlistClick),
                                  ).then((isCart) {
                                    return switch (isCart) {
                                      false => _wishlistKey,
                                      _ => _cartKey,
                                    };
                                  });
                                },
                                child: IngredientCard(
                                  ingredient: state.ingredients[index],
                                ).paddingHorizontal(0),
                              ),
                            ),
                          ),
                    _ => const Text('error').center(),
                  };
                },
              ).padding(AppConfig.pagePadding).expand(),
            ],
          ),
        ),
      ),
    );
  }
}
