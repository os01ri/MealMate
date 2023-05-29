part of '../pages/ingredient_page.dart';

class _IngredientBudgetCard extends StatelessWidget {
  const _IngredientBudgetCard({
    required this.quantity,
    required this.price,
  });

  final int quantity;
  final int price;

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
            const Icon(Icons.remove),
            Text(
              '$quantity Kg',
              style: const TextStyle().middleFontSize.bold,
            ).paddingHorizontal(2),
            const Icon(Icons.add),
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
