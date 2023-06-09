import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/ui/widgets/error_widget.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/domain/usecases/index_wishlist_usecase.dart';
import 'package:mealmate/features/store/presentation/cubit/store_cubit/store_cubit.dart';
import 'package:mealmate/features/store/presentation/pages/store_page.dart';
import 'package:mealmate/router/routes_names.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({
    super.key,
    required this.onAddToCart,
  });

  final void Function(GlobalKey) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..getWishlist(const IndexWishlistParams()),
      child: Scaffold(
        appBar: RecipeAppBar(
          context: context,
          title: 'Wishlist',
        ),
        body: Padding(
          padding: AppConfig.pagePadding.copyWith(top: 20),
          child: BlocBuilder<StoreCubit, StoreState>(
            builder: (context, state) {
              if (state.indexWishlistStatus == CubitStatus.loading) {
                return const CircularProgressIndicator.adaptive().center();
              } else if (state.indexWishlistStatus == CubitStatus.success) {
                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: .85,
                  ),
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    state.wishItems.length,
                    (index) => GestureDetector(
                      onTap: () async {
                        context.pushNamed(
                          RoutesNames.ingredient,
                          extra: (onAddToCart, onAddToCart),
                        );
                      },
                      child: IngredientCard(
                        ingredient: state.wishItems[index].ingredient!,
                      ).paddingHorizontal(0),
                    ),
                  ),
                );
              } else {
                return MainErrorWidget(
                  onTap: () {
                    context.read<StoreCubit>().getWishlist(const IndexWishlistParams());
                  },
                  size: context.deviceSize,
                ).center();
              }
            },
          ),
        ),
      ),
    );
  }
}
