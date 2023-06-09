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
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/show_ingredient_usecase.dart';
import 'package:mealmate/features/store/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:mealmate/features/store/presentation/cubit/store_cubit/store_cubit.dart';
import 'package:mealmate/dependency_injection.dart';

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

  @override
  void initState() {
    super.initState();
    _widgetKey = GlobalKey();
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
              return Text(serviceLocator<LocalizationClass>().appLocalizations!.error).center();
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
                          quantity: state.ingredient!.priceBy!,
                        ).paddingVertical(8),
                        const _InfoList().expand(),
                      ],
                    ).expand(),
                    MainButton(
                      color: AppColors.mainColor,
                      onPressed: () {
                        context.pop(true);
                        widget.onAddToCart(_widgetKey);
                        serviceLocator<CartCubit>().addOrUpdateProduct(ingredient: state.ingredient!);
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
      UiMessages.showLoading();
    } else if (state.addToWishlistStatus == CubitStatus.failure) {
      UiMessages.closeLoading();
      UiMessages.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    } else if (state.addToWishlistStatus == CubitStatus.success) {
      UiMessages.closeLoading();
      UiMessages.showToast('تم');
      context.pop(false);
      widget.onAddToWishlist(_widgetKey);
    }
  }
}

class _InfoList extends StatelessWidget {
  const _InfoList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < 6; i++)
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'كالوري $i',
                style: const TextStyle().normalFontSize.semiBold,
              ),
              const Spacer(),
              const Text(
                '250 KCal',
                style: TextStyle(),
              ),
              Icon(
                switch (i) {
                  <= 2 => Icons.check_circle_outline_rounded,
                  _ => Icons.warning_amber_rounded,
                },
                color: switch (i) {
                  <= 2 => Colors.green,
                  _ => Colors.red,
                },
              ).paddingHorizontal(5),
            ],
          ).paddingAll(8),
      ],
    );
  }
}
