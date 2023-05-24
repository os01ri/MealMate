part of '../pages/ingredient_page.dart';

class _RecipeBudget extends StatelessWidget {
  const _RecipeBudget();

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
            const Text('2 Kg').paddingHorizontal(12),
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
              '5,000 SYP',
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
