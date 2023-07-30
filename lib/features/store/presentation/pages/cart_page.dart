import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/number_extension.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/order_item_model.dart';
import '../../domain/usecases/place_order_usecase.dart';
import '../cubit/cart_cubit/cart_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late final CartCubit _cartCubit;

  @override
  void initState() {
    _cartCubit = serviceLocator<CartCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        centerText: true,
        actions: const [],
        title: "Your Food Cart",
      ),
      body: BlocConsumer<CartCubit, CartState>(
        bloc: _cartCubit,
        listener: (context, state) {
          if (state.orderStatus == OrderStatus.loading) {
            Toaster.showLoading();
          } else if (state.orderStatus == OrderStatus.placed) {
            Toaster.closeLoading();
            context.myPushNamed(RoutesNames.orderPlacedPage);
          }
        },
        builder: (context, state) {
          return Container(
            color: AppColors.mainColor.withOpacity(.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.height * .5,
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CartItemWidget(
                          item: state.cartItems[index],
                          onAdd: () {
                            _cartCubit.addOrUpdateProduct(ingredient: state.cartItems[index].model!, quantity: 1);
                          },
                          onRemove: () {
                            _cartCubit.deleteProduct(
                              ingredient: state.cartItems[index].model!,
                            );
                          },
                          onDelete: () {
                            _cartCubit.deleteProduct(ingredient: state.cartItems[index].model!, remove: true);
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: context.height * .5 - 119,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.circle, size: 10),
                                SizedBox(
                                  width: context.width * .8,
                                  child: const Divider(color: AppColors.brown, thickness: 2, indent: 0),
                                ),
                                const Icon(Icons.circle, size: 10),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                serviceLocator<LocalizationClass>().appLocalizations!.shippingFee,
                                style: AppTextStyles.styleWeight600(fontSize: 18),
                              ),
                              Text(
                                "5,000 ل.س",
                                style: AppTextStyles.styleWeight400(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                serviceLocator<LocalizationClass>().appLocalizations!.totalPayment,
                                style: AppTextStyles.styleWeight600(fontSize: 18),
                              ),
                              Text(
                                '${state.getTotalPrice()} ل.س',
                                style: AppTextStyles.styleWeight400(fontSize: 18),
                              )
                            ],
                          ),
                          MainButton(
                            fontSize: 20,
                            width: context.width * .55,
                            text: serviceLocator<LocalizationClass>().appLocalizations!.pleaseAddYourAddress,
                            icon: const Icon(Icons.location_on_outlined, size: 35),
                            color: AppColors.lightTextColor,
                            onPressed: () {},
                          ),
                          MainButton(
                            width: context.width * .75,
                            text: serviceLocator<LocalizationClass>().appLocalizations!.placeOrder,
                            color: AppColors.orange,
                            onPressed: () {
                              if (_cartCubit.state.cartItems.isNotEmpty) {
                                _cartCubit.placeOrderToState(
                                  params: PlaceOrderParams(
                                    ingredients: _cartCubit.state.cartItems
                                        .map(
                                          (e) => OrderItemModel(
                                            unitId: e.model!.unit!.id!,
                                            ingredientId: e.model!.id!,
                                            quantity: e.quantity,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  final CartItemModel item;
  final VoidCallback onAdd, onDelete, onRemove;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Row(
        children: [
          CachedNetworkImage(
            hash: widget.item.model!.hash!,
            url: widget.item.model!.url!,
            fit: BoxFit.fitHeight,
            width: context.width * .2,
            height: context.width * .2,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.model!.name ?? "Ingredients"),
              Text('${(widget.item.quantity * widget.item.model!.price!).numberFormat()} ل.س'),
              Text("total ${widget.item.model!.priceBy! * widget.item.quantity} ${widget.item.model!.unit!.code}"),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              height: context.height * .08,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppColors.mainColor,
                    size: context.height * .04,
                  ).onTap(() => widget.onDelete()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.add,
                        color: AppColors.mainColor,
                      ).onTap(() => widget.onAdd()),
                      Container(
                        width: context.width * .2,
                        height: context.height * .03,
                        color: AppColors.mainColor,
                        padding: const EdgeInsets.all(4),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "${widget.item.quantity}",
                            style: AppTextStyles.styleWeight600(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                      const Icon(Icons.remove).onTap(() => widget.onRemove()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
