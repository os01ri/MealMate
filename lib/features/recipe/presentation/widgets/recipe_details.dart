part of '../pages/recipe_page.dart';

class _RecipeDetails extends StatelessWidget {
  const _RecipeDetails();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * .6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          const _RecipeHeader().padding(const EdgeInsets.all(8)),
          const _NutritionalValues(),
          const _NumberOfEaters().padding(const EdgeInsets.all(10)),
          Column(
            children: [
              for (int i = 0; i < 6; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Checken Breasts', style: TextStyle().normalFontSize.semiBold),
                    Text('250 g'),
                  ],
                ).padding(const EdgeInsets.all(8)),
            ],
          ).scrollable().expand(),
          MainButton(
            color: AppColors.buttonColor,
            onPressed: () {},
            width: context.width,
            text: 'Start Cocking!',
          ).padding(const EdgeInsets.all(8)),
        ],
      ),
    );
  }
}

class _RecipeHeader extends StatelessWidget {
  const _RecipeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.refresh,
          ),
        ),
        Column(
          children: [
            Text(
              'Pasta',
              style: const TextStyle().largeFontSize.bold,
            ),
            Text(
              'Launch / 15 min',
              style: const TextStyle().smallFontSize.regular,
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
          ),
        ),
      ],
    );
  }
}

class _NutritionalValues extends StatelessWidget {
  const _NutritionalValues();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.all(15),
      color: AppColors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Text('20 g'),
              Text('Protin'),
            ],
          ),
          Column(
            children: const [
              Text('15 g'),
              Text('Karbs'),
            ],
          ),
          Column(
            children: const [
              Text('50 g'),
              Text('Fats'),
            ],
          ),
          Column(
            children: const [
              Text('20 g'),
              Text('Protin'),
            ],
          ),
        ],
      ),
    );
  }
}

class _NumberOfEaters extends StatelessWidget {
  const _NumberOfEaters();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Ingredients:', style: TextStyle().normalFontSize.bold),
        Row(
          children: [
            Icon(Icons.remove),
            Text('Serves 2').padding(EdgeInsets.symmetric(horizontal: 5)),
            Icon(Icons.add),
          ],
        ),
      ],
    );
  }
}
