import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/ui_messages.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../domain/usecases/index_wishlist_usecase.dart';
import '../../domain/usecases/remove_from_wishlist_usecase.dart';
import '../cubit/cart_cubit/cart_cubit.dart';
import '../cubit/store_cubit/store_cubit.dart';
import '../widgets/ingredient_card.dart';

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
          child: BlocConsumer<StoreCubit, StoreState>(
            listener: _listener,
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
                    (index) {
                      late final List<GlobalKey> widgetKeys = List.generate(
                        state.wishItems.length,
                        (_) => GlobalKey(),
                      );

                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return SimpleDialog(
                                backgroundColor: Colors.white,
                                contentPadding: const EdgeInsets.all(30),
                                title: Text(state.wishItems[index].ingredient!.name!).center(),
                                shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
                                children: [
                                  MainButton(
                                    text: 'إضافة إلى السلة',
                                    color: AppColors.mainColor,
                                    onPressed: () {
                                      onAddToCart(widgetKeys[index]);
                                      serviceLocator<CartCubit>().addOrUpdateProduct(
                                          ingredient: state.wishItems[index].ingredient!, quantity: 1);
                                      Toaster.showToast(
                                        serviceLocator<LocalizationClass>().appLocalizations!.addedToCart,
                                      );
                                      context.pop();
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MainButton(
                                    text: 'إزالة من المفضلة',
                                    textColor: AppColors.brown,
                                    color: Colors.white,
                                    onPressed: () {
                                      context.read<StoreCubit>().removeFromWishlist(
                                            RemoveFromWishlistParams(
                                              ingredientId: state.wishItems[index].id!,
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MainButton(
                                    text: 'إغلاق',
                                    textColor: AppColors.lightRed,
                                    color: Colors.white,
                                    onPressed: () => context.pop(),
                                  ),
                                ],
                              );
                            },
                          );
                          // (onAddToCart, onAddToCart)
                        },
                        child: IngredientCard(
                          widgetKey: widgetKeys[index],
                          ingredient: state.wishItems[index].ingredient!,
                        ).paddingHorizontal(0),
                      );
                    },
                  ),
                );
              } else {
                return MainErrorWidget(
                  onTap: () {
                    context.read<StoreCubit>().getWishlist(const IndexWishlistParams());
                  },
                ).center();
              }
            },
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, StoreState state) {
    if (state.removeFromWishlistStatus == CubitStatus.loading) {
      Toaster.showLoading();
    } else if (state.removeFromWishlistStatus == CubitStatus.failure) {
      Toaster.closeLoading();
      Toaster.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    } else if (state.removeFromWishlistStatus == CubitStatus.success) {
      Toaster.closeLoading();
      context.pop();
    }
  }
}
