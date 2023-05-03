part of '../pages/recipe_page.dart';

class _RecipeStepsView extends StatelessWidget {
  const _RecipeStepsView({
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Step 4',
            style: const TextStyle().bold.largeFontSize,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i < 4; i++)
                StepBullet(
                  isActive: false,
                  stepNumber: i,
                ),
              const StepBullet(
                isActive: true,
                child: Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              for (int i = 0; i < 2; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Checken Breasts',
                      style: const TextStyle().normalFontSize.semiBold,
                    ),
                    const Text(
                      '250 g',
                      style: TextStyle(),
                    ),
                  ],
                ).padding(const EdgeInsets.all(8)),
                const Divider(),
              ],
            ],
          ),
          Text(
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa ',
            style: const TextStyle().normalFontSize.regular,
          ).padding(const EdgeInsets.symmetric(vertical: 15)).scrollable().expand(),
          Row(
            children: [
              MainButton(
                color: AppColors.grey,
                onPressed: () {
                  pageController.animateToPage(
                    pageController.page!.ceil() - 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.ease,
                  );
                },
                text: 'Previous',
                textColor: Colors.black,
              ).padding(const EdgeInsets.all(8)).expand(),
              MainButton(
                color: AppColors.buttonColor,
                onPressed: () {},
                text: 'Finish Cooking',
              ).padding(const EdgeInsets.all(8)).expand(),
            ],
          ),
        ],
      ),
    );
  }
}

class StepBullet extends StatelessWidget {
  const StepBullet({
    super.key,
    this.child,
    this.stepNumber,
    required this.isActive,
  }) : assert(child != null || stepNumber != null);

  final Widget? child;
  final int? stepNumber;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      padding: const EdgeInsets.all(2),
      width: context.width * .05,
      height: context.width * .05,
      decoration: BoxDecoration(
        color: isActive ? AppColors.buttonColor : Colors.white,
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(100),
      ),
      child: FittedBox(
        child: child ??
            Text(
              '${stepNumber!}',
              style: TextStyle(color: isActive ? Colors.white : Colors.black),
            ).center(),
      ),
    );
  }
}
