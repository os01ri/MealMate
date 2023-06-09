import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/injection_container.dart';

import '../../../../core/cubit/cart_cubit/cart_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: context.height * .4,
              child: BlocConsumer<CartCubit, CartState>(
                bloc: _cartCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: state.cartItems.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          leading: Image.network(
                            state.cartItems[index].model!.url ?? PngPath.food,
                            fit: BoxFit.fill,
                            width: context.width * .2,
                            height: context.width * .2,
                          ),
                          title: Text(state.cartItems[index].model!.name ??
                              "Ingredients"),
                          subtitle: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("1 KG"), Text("1000 ل.س")],
                          ),
                          trailing: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.add).onTap(() =>
                                      _cartCubit.addOrUpdateProduct(
                                          ingredient:
                                              state.cartItems[index].model!)),
                                  Container(
                                      color: AppColors.grey2,
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        "${state.cartItems[index].quantity}",
                                        style: AppTextStyles.styleWeight500(
                                            fontSize: 20),
                                      )),
                                  const Icon(Icons.minimize).onTap(() =>
                                      _cartCubit.deleteProduct(
                                          ingredient:
                                              state.cartItems[index].model!))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
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
                          child: const Divider(
                              color: AppColors.brown, thickness: 2, indent: 0),
                        ),
                        const Icon(Icons.circle, size: 10),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        serviceLocator<LocalizationClass>()
                            .appLocalizations!
                            .shippingFee,
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
                        serviceLocator<LocalizationClass>()
                            .appLocalizations!
                            .totalPayment,
                        style: AppTextStyles.styleWeight600(fontSize: 18),
                      ),
                      Text(
                        "20,000 SYP",
                        style: AppTextStyles.styleWeight400(fontSize: 18),
                      )
                    ],
                  ),
                  MainButton(
                      fontSize: 20,
                      width: context.width * .55,
                      text: serviceLocator<LocalizationClass>()
                          .appLocalizations!
                          .pleaseAddYourAddress,
                      icon: const Icon(Icons.location_on_outlined, size: 35),
                      color: AppColors.lightTextColor,
                      onPressed: () {}),
                  MainButton(
                    width: context.width * .75,
                    text: serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .placeOrder,
                    color: AppColors.orange,
                    onPressed: () {},
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
