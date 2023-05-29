import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.arguments});
  final CartArguments arguments;
  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        centerText: true,
        actions: [],
        title: "Order Preview",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: context.height * .4,
              child: ListView.builder(
                  itemCount: widget.arguments.ingredients.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      leading: Image.network(
                        widget.arguments.ingredients[index].url ?? PngPath.food,
                        fit: BoxFit.fill,
                        width: context.width * .2,
                        height: context.width * .2,
                      ),
                      title: Text(widget.arguments.ingredients[index].name ??
                          "Ingredients"),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("1 KG"), Text("1000 SYP")],
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.add),
                              ValueListenableBuilder(
                                valueListenable: ValueNotifier(0),
                                builder: (BuildContext context, dynamic value,
                                    Widget? child) {
                                  return Container(
                                      color: AppColors.grey2,
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        "$value",
                                        style: AppTextStyles.styleWeight500(
                                            fontSize: 20),
                                      ));
                                },
                              ),
                              const Icon(Icons.minimize)
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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
                        Icon(Icons.circle, size: 10),
                        SizedBox(
                          width: context.width * .7,
                          child: const Divider(
                              color: AppColors.brown, thickness: 2, indent: 0),
                        ),
                        Icon(Icons.circle, size: 10),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Shipping Fee",
                        style: AppTextStyles.styleWeight600(fontSize: 18),
                      ),
                      Text(
                        "0.59 SYP",
                        style: AppTextStyles.styleWeight400(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Total Payment",
                        style: AppTextStyles.styleWeight600(fontSize: 18),
                      ),
                      Text(
                        "2.0 SYP",
                        style: AppTextStyles.styleWeight400(fontSize: 18),
                      )
                    ],
                  ),
                  MainButton(
                      fontSize: 20,
                      width: context.width * .55,
                      text: 'Please Add Your Address',
                      icon: Icon(Icons.location_on_outlined, size: 35),
                      color: AppColors.lightTextColor,
                      onPressed: () {}),
                  MainButton(
                      width: context.width * .75,
                      text: "Place Order",
                      color: AppColors.orange,
                      onPressed: () {})
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class CartArguments {
  final List<IngredientModel> ingredients;

  CartArguments({required this.ingredients});
}
