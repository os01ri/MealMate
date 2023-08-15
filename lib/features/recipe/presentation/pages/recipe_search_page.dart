import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../widgets/category_choice_chip.dart';
import '../widgets/floating_search_text_failed.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> with TickerProviderStateMixin {
  late TabController tabController;

  late FloatingSearchBarController floatingSearchBarController;

  @override
  void initState() {
    tabController = TabController(
      vsync: this,
      length: 4,
    )..addListener(() {});
    floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SearchBody(tabController: tabController),
          FloatingSearchTextFailed(floatingSearchBarController: floatingSearchBarController),
        ],
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  SearchBody({super.key, required this.tabController});

  final TabController tabController;
  final ValueNotifier<int> _selectedCat = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: context.width * .16,
        leading: const SizedBox.square(),
      ),
      body: Column(
        children: [
          _buildCategoriesListView(context),
          TabBarView(
            controller: tabController,
            children: const [
              SizedBox.shrink(),
              SizedBox.shrink(),
              SizedBox.shrink(),
              SizedBox.shrink(),
            ],
          ).expand(),
        ],
      ),
    );
  }

  Widget _buildCategoriesListView(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, value, child) {
          return RefreshIndicator(
            onRefresh: () async {
              // context.read<StoreCubit>().getIngredients(IndexIngredientsParams(
              //       categoryId: value != 0 ? state.ingredientsCategories[value].id : null,
              //     ));
            },
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(end: 15),
              children: [
                CategoryChoiceChip(
                  title: 'الكـل',
                  isActive: 0 == value,
                  onTap: () {
                    _selectedCat.value = 0;
                  },
                ),
                CategoryChoiceChip(
                  title: 'الإفطار',
                  isActive: 1 == value,
                  onTap: () {
                    _selectedCat.value = 1;
                  },
                ),
                CategoryChoiceChip(
                  title: 'الغداء',
                  isActive: 2 == value,
                  onTap: () {
                    _selectedCat.value = 2;
                  },
                ),
                CategoryChoiceChip(
                  title: 'العشاء',
                  isActive: 3 == value,
                  onTap: () {
                    _selectedCat.value = 3;
                  },
                ),
              ],
            ),
          );
        },
      ).paddingVertical(10),
    );
  }
}
