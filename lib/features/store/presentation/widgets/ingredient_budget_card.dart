part of '../pages/ingredient_page.dart';

class _IngredientBudgetCard extends StatelessWidget {
  const _IngredientBudgetCard({
    required this.priceByUnit,
    required this.price,
    required this.quantity,
  });

  final int priceByUnit;
  final int price;
  final ValueNotifier<int> quantity;
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _DetailCardRow(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
              color: AppColors.mainColor,
              child: const Icon(
                Icons.workspaces_outline,
                color: Colors.white,
              ).paddingAll(10),
            ),
            const Icon(Icons.remove).onTap(() {
              if (quantity.value > 1) {
                quantity.value--;
              }
            }),
            ValueListenableBuilder(
              valueListenable: quantity,
              builder: (BuildContext context, int value, Widget? child) {
                return Text(
                  '$value Kg',
              style: const TextStyle().middleFontSize.bold,
                ).paddingHorizontal(2);
              },
            ),
            const Icon(Icons.add).onTap(() {
              quantity.value++;
            }),
          ],
        ).expand(),
        _DetailCardRow(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
              color: AppColors.mainColor,
              child: const Icon(
                Icons.payments_rounded,
                color: Colors.white,
              ).paddingAll(10),
            ),
            Text(
              '$price SYP',
              style: const TextStyle().bold,
              textAlign: TextAlign.center,
            ).expand(),
          ],
        ).expand(),
      ],
    );
  }
}

class _DetailCardRow extends StatelessWidget {
  const _DetailCardRow({
    required this.children,
    // ignore: unused_element
    this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  });

  final List<Widget> children;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
      child: Row(
        children: children,
      ).padding(margin),
    );
  }
}
