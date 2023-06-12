import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/cache_network_image.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/data/models/order_item_model.dart';
import 'package:mealmate/features/store/domain/usecases/place_order_usecase.dart';
import 'package:mealmate/features/store/presentation/cubit/cart_cubit/cart_cubit.dart';

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
        title: "Order Preview",
      ),
      body: BlocConsumer<CartCubit, CartState>(
        bloc: _cartCubit,
        listener: (context, state) {
          if (state.orderStatus == OrderStatus.placed) {
            context.pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: context.height * .4,
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        leading: CachedNetworkImage(
                          hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
                          url: state.cartItems[index].model!.url!,
                          fit: BoxFit.fitHeight,
                          width: context.width * .2,
                          height: context.width * .2,
                        ),
                        title: Text(state.cartItems[index].model!.name ?? "Ingredients"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("1 KG"),
                            Text("${state.cartItems[index].model!.price!} ل.س"),
                          ],
                        ),
                        trailing: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.add).onTap(
                                    () =>
                                    _cartCubit.addOrUpdateProduct(
                                        ingredient:
                                            state.cartItems[index].model!,
                                        quantity: 1)),
                                Container(
                                    color: AppColors.grey2,
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      "${state.cartItems[index].quantity}",
                                      style: AppTextStyles.styleWeight500(fontSize: 20),
                                    )),
                                const Icon(Icons.minimize).onTap(
                                  () => _cartCubit.deleteProduct(
                                    ingredient: state.cartItems[index].model!,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: context.height * .4,
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
                              width: context.width * .7,
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
                                        unitId: e.model!.priceBy!,
                                        ingredientId: e.model!.id!,
                                        quantity: e.quantity,
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
