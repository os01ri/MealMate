part of '../pages/recipe_page.dart';

class _RecipeDetails extends StatefulWidget {
  const _RecipeDetails();

  @override
  State<_RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<_RecipeDetails> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _RecipeIngredientsView(pageController: _pageController),
          _RecipeStepsView(pageController: _pageController),
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
        Text('Ingredients:', style: const TextStyle().normalFontSize.bold),
        Row(
          children: [
            const Icon(Icons.remove),
            const Text('Serves 2').paddingAll(5),
            const Icon(Icons.add),
          ],
        ),
      ],
    );
  }
}
