part of '../pages/ingredient_page.dart';

class _IngredientBudgetCard extends StatelessWidget {
  const _IngredientBudgetCard({
    required this.priceByUnit,
    required this.price,
    required this.quantity,
    required this.unit,
  });
  final String unit;
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
              shape:
                  RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
              color: AppColors.mainColor,
              child: const Icon(
                Icons.workspaces_outline,
                color: Colors.white,
              ).paddingAll(10),
            ),
            const Icon(Icons.remove).onTap(() {
              if (quantity.value > priceByUnit) {
                quantity.value -= priceByUnit;
              }
            }),
            ValueListenableBuilder(
              valueListenable: quantity,
              builder: (BuildContext context, int value, Widget? child) {
                return Text(
                  '$value $unit',
                  style: const TextStyle().normalFontSize.bold,
                ).paddingHorizontal(2);
              },
            ),
            const Icon(Icons.add).onTap(() {
              quantity.value += priceByUnit;
            }),
          ],
        ).expand(),
        _DetailCardRow(
          children: [
            Card(
              shape:
                  RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
              color: AppColors.mainColor,
              child: const Icon(
                Icons.payments_rounded,
                color: Colors.white,
              ).paddingAll(10),
            ),
            ValueListenableBuilder(
              valueListenable: quantity,
              builder: (_, value, child) {
                return Text(
                  '${(price * quantity.value / priceByUnit).toStringAsFixed(0)} ${serviceLocator<LocalizationClass>().appLocalizations!.syp}',
                  style: const TextStyle().bold.normalFontSize,
                  textAlign: TextAlign.center,
                ).expand();
              },
            )
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ).padding(margin),
    );
  }
}
