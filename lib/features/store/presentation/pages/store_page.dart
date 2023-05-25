import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate/router/app_routes.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final StoreCubit _storeCubit;
  late GlobalKey<CartIconKey> _cartKey;
  late Function(GlobalKey) _runAddToCartAnimation;
  var _cartQuantityItems = 0;

  @override
  void initState() {
    super.initState();

    _storeCubit = StoreCubit()..getIngredients(IndexIngredientsParams());
    _cartKey = GlobalKey<CartIconKey>();
  }

  void listClick(GlobalKey widgetKey) async {
    await _runAddToCartAnimation(widgetKey);
    await _cartKey.currentState!.runCartAnimation((++_cartQuantityItems).toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _storeCubit,
      child: AddToCartAnimation(
        // To send the library the location of the Cart icon
        cartKey: _cartKey,
        height: 30,
        width: 30,
        opacity: .9,
        dragAnimation: const DragToCartAnimationOptions(rotation: true, duration: Duration(milliseconds: 400)),
        jumpAnimation: const JumpAnimationOptions(active: false, duration: Duration(milliseconds: 150)),
        createAddToCartAnimation: (runAddToCartAnimation) => _runAddToCartAnimation = runAddToCartAnimation,
        child: Scaffold(
          appBar: RecipeAppBar(
            context: context,
            centerText: true,
            title: 'Grocery Store',
            leadingWidget: const SizedBox.shrink(),
            actions: [
              AddToCartIcon(
                key: _cartKey,
                badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Row(
                children: [
                  MainTextField(
                    controller: TextEditingController(),
                    hint: 'Search Ingredients',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.filter_alt),
                    ),
                  ).paddingVertical(15).expand(),
                ],
              ),
              BlocBuilder<StoreCubit, StoreState>(
                bloc: _storeCubit,
                builder: (BuildContext context, StoreState state) {
                  return switch (state.status) {
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
                                onTap: () => context.push(Routes.ingredientPage, extra: listClick),
                                child: _Card(
                                  index: index,
                                  title: state.ingredients[index].name!,
                                ).paddingHorizontal(0),
                              ),
                            ),
                          ),
                    _ => const Text('error').center(),
                  };
                },
              ).expand(),
            ],
          ).padding(AppConfig.pagePadding),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(
            // state.ingredients[index].imageUrl!,
            PngPath.tomato,
            fit: BoxFit.fitWidth,
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: context.width * .3,
                child: Text(
                  title,
                  softWrap: true,
                  style: const TextStyle().normalFontSize.bold,
                ),
              ),
              SizedBox(
                width: context.width * .3,
                child: Text(
                  // '1 Kg => ${state.ingredients[index].price}\$',
                  '1 Kg => 5000 SYP',
                  style: const TextStyle(color: AppColors.lightTextColor).smallFontSize.semiBold,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
