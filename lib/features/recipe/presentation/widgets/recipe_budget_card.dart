// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../pages/recipe_details_page.dart';

class _RecipeBudget extends StatelessWidget {
  final int price, stepsCount, persons;
  final String duration;
  const _RecipeBudget({
    Key? key,
    required this.persons,
    required this.duration,
    required this.price,
    required this.stepsCount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DetailCardRow(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
                  color: AppColors.mainColor,
                  child: const Icon(
                    Icons.timer_outlined,
                    color: Colors.white,
                  ).paddingAll(10),
                ),
                Text(
                  '${duration} min',
                  style: const TextStyle().bold,
                  textAlign: TextAlign.center,
                ).expand(),
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
                  '${price} SYP',
                  style: const TextStyle().bold,
                  textAlign: TextAlign.center,
                ).expand(),
              ],
            ).expand(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DetailCardRow(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
                  color: AppColors.mainColor,
                  child: const Icon(
                    Icons.people_alt_outlined,
                    color: Colors.white,
                  ).paddingAll(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.remove),
                    Text('$persons').paddingHorizontal(12),
                    const Icon(Icons.add),
                  ],
                ).expand(),
              ],
            ).expand(),
            _DetailCardRow(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
                  color: AppColors.mainColor,
                  child: const Icon(
                    Icons.account_tree_rounded,
                    color: Colors.white,
                  ).paddingAll(10),
                ),
                Text(
                  '$stepsCount Steps',
                  style: const TextStyle().bold,
                  textAlign: TextAlign.center,
                ).expand(),
              ],
            ).expand(),
          ],
        ),
      ],
    );
  }
}

class _DetailCardRow extends StatelessWidget {
  const _DetailCardRow({
    required this.children,
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
