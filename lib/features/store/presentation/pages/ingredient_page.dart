import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/ui_messages.dart';
import 'package:mealmate/core/ui/widgets/cache_network_image.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/show_ingredient_usecase.dart';
import 'package:mealmate/features/store/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:mealmate/features/store/presentation/cubit/store_cubit/store_cubit.dart';

part '../widgets/ingredient_budget_card.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({
    super.key,
    required this.onAddToCart,
    required this.onAddToWishlist,
    required this.id,
  });
  final void Function(GlobalKey) onAddToCart;
  final void Function(GlobalKey) onAddToWishlist;
  final String id;

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  late final GlobalKey _widgetKey;
  late final ValueNotifier<int> quantity;

  @override
  void initState() {
    super.initState();
    _widgetKey = GlobalKey();
    quantity = ValueNotifier(1);
    log(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..showIngredient(ShowIngredientParams(id: widget.id)),
      child: Scaffold(
        body: BlocConsumer<StoreCubit, StoreState>(
          listener: _listener,
          builder: (context, state) {
            if (state.showStatus == CubitStatus.loading) {
              return const CircularProgressIndicator.adaptive().center();
            } else if (state.showStatus == CubitStatus.failure) {
              return MainErrorWidget(
                onTap: () {
                  context.read<StoreCubit>().showIngredient(ShowIngredientParams(id: widget.id));
                },
              ).center();
            } else {
              return Scaffold(
                appBar: RecipeAppBar(
                  context: context,
                  title: state.ingredient!.name!,
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<StoreCubit>().addToWishlist(AddToWishlistParams(
                              ingredientId: state.ingredient!.id!,
                            ));
                      },
                      icon: const Icon(Icons.bookmark_add_outlined),
                    ),
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          key: _widgetKey,
                          child: CachedNetworkImage(
                            hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
                            url: state.ingredient!.url!,
                            width: context.width,
                            height: context.width,
                          ),
                        ),
                        _IngredientBudgetCard(
                          price: state.ingredient!.price!,
                          priceByUnit: state.ingredient!.priceBy!,
                          quantity: quantity,
                        ).paddingVertical(8),
                        _InfoList(nutritional: state.ingredient!.nutritionals!).expand(),
                      ],
                    ).expand(),
                    MainButton(
                      color: AppColors.mainColor,
                      onPressed: () {
                        context.pop(true);
                        widget.onAddToCart(_widgetKey);
                        serviceLocator<CartCubit>()
                            .addOrUpdateProduct(ingredient: state.ingredient!, quantity: quantity.value);
                      },
                      width: context.width,
                      text: serviceLocator<LocalizationClass>().appLocalizations!.addToCart,
                    ).paddingHorizontal(8).hero('button'),
                  ],
                ).padding(AppConfig.pagePadding),
              );
            }
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, StoreState state) {
    if (state.addToWishlistStatus == CubitStatus.loading) {
      Toaster.showLoading();
    } else if (state.addToWishlistStatus == CubitStatus.failure) {
      Toaster.closeLoading();
      Toaster.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    } else if (state.addToWishlistStatus == CubitStatus.success) {
      Toaster.closeLoading();
      context.pop(false);
      widget.onAddToWishlist(_widgetKey);
    }
  }
}

class _InfoList extends StatelessWidget {
  const _InfoList({required this.nutritional});
  final List<Nutritional> nutritional;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nutritional.length,
      itemBuilder: (context, index) {
        return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' ${nutritional[index].name}',
              style: const TextStyle().normalFontSize.semiBold,
            ),
            const Spacer(),
            Text(
              '${nutritional[index].ingredientNutritionals!.value}',
              style: const TextStyle(),
            ),
            Icon(
              switch (index) {
                <= 2 => Icons.check_circle_outline_rounded,
                _ => Icons.warning_amber_rounded,
              },
              color: switch (index) {
                <= 2 => Colors.green,
                _ => Colors.red,
              },
            ).paddingHorizontal(5),
          ],
        ).paddingAll(8);
      },
    );
  }
}
