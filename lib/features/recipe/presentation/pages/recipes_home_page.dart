import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/skelton_loading.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../../welcoming/presentation/cubit/user_cubit.dart';
import '../../data/models/recipe_model.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../cubit/recipe_cubit.dart';
import '../widgets/category_choice_chip.dart';
import '../widgets/section_header.dart';

part '../widgets/recipe_card.dart';

enum IndexType { newest, followings, trending, mostRated }

class RecipesHomePage extends StatefulWidget {
  const RecipesHomePage({super.key});

  @override
  State<RecipesHomePage> createState() => _RecipesHomePageState();
}

class _RecipesHomePageState extends State<RecipesHomePage> {
  late ValueNotifier<double> _bodyPosition;
  late ValueNotifier<double> _searchButtonPosition;
  late ValueNotifier<bool> _allowScroll;
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  static double _bodyUpPosition(BuildContext context) => context.height * .15;
  static double _bodyDownPosition(BuildContext context) => context.height * .38;

  static double _searchButtonUpPosition(BuildContext context) => context.height * .06;
  static double _searchButtonDownPosition(BuildContext context) => context.height * .29;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bodyPosition = ValueNotifier(_bodyDownPosition(context));
    _searchButtonPosition = ValueNotifier(_searchButtonDownPosition(context));
    _allowScroll = ValueNotifier(false);
  }

  _buildOrangeContainer(BuildContext context) {
    return Container(
      height: context.height * .6,
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: context.height * .07),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            AppColors.orange,
            AppColors.lightOrange,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // IconButton(
              //   onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              //   icon: Icon(
              //     Icons.menu_open_rounded,
              //     color: Colors.white,
              //     size: FontSize.heading_02,
              //   ),
              // ),
              Text(
                '${serviceLocator<LocalizationClass>().appLocalizations!.hello} ${serviceLocator<UserCubit>().state.user!.name!.split(' ').first}!',
                style: const TextStyle(color: Colors.white).semiBold.xLargeFontSize,
              ),
            ],
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: _allowScroll.value ? Colors.transparent : Colors.white,
              fontFamily: 'Almarai',
            ).bold.xxLargeFontSize,
            child: Text(serviceLocator<LocalizationClass>().appLocalizations!.whatToCook),
          ),
          SizedBox(height: context.height * .22),
        ],
      ),
    ).positioned(top: 0);
  }

  _buildSearchButton(BuildContext context) {
    final isDown = (_searchButtonPosition.value == _searchButtonDownPosition(context));
    return AnimatedPositionedDirectional(
      top: _searchButtonPosition.value,
      end: 20,
      duration: AppConfig.animationDuration,
      child: AnimatedContainer(
        duration: AppConfig.animationDuration,
        width: isDown ? (context.width - 40) : 55,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isDown ? 25 : 55),
          ),
          child: Row(
            children: [
              const Icon(Icons.search_rounded),
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: AppConfig.animationDuration,
                  style: TextStyle(
                    fontSize: isDown ? 14 : 0,
                    color: Colors.black,
                    fontFamily: 'Almarai',
                  ),
                  child: Text(
                    serviceLocator<LocalizationClass>().appLocalizations!.searchRecipes,
                  ).paddingHorizontal(10),
                ),
              ),
            ],
          ),
        ),
      ).onTap(() => context.myPushNamed(RoutesNames.recipesSearch)),
    );
  }

  _buildBody(BuildContext context) {
    return AnimatedPositioned(
      top: _bodyPosition.value,
      duration: AppConfig.animationDuration,
      child: _BodyWidget(
        onDrag: _toggleBodyState,
        allowScroll: _allowScroll,
      ),
    );
  }

  _toggleBodyState(DragUpdateDetails val) {
    setState(() {
      if (val.delta.dy > 0) {
        _bodyPosition.value = _bodyDownPosition(context);
        _searchButtonPosition.value = _searchButtonDownPosition(context);
        _allowScroll.value = false;
      } else if (val.delta.dy < 0) {
        _bodyPosition.value = _bodyUpPosition(context);
        _searchButtonPosition.value = _searchButtonUpPosition(context);
        _allowScroll.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit()
        ..indexCategories()
        ..indexRecipes(const IndexRecipesParams())
        ..indexRecipesMostRated(const IndexRecipesParams())
        ..indexRecipesTrending(const IndexRecipesParams())
        ..indexRecipesBuyFollowings(const IndexRecipesParams()),
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: const MainDrawer(),
        body: Stack(
          children: [
            _buildOrangeContainer(context),
            _buildSearchButton(context),
            _buildBody(context),
          ],
        ),
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({
    required this.onDrag,
    required this.allowScroll,
  });

  final void Function(DragUpdateDetails) onDrag;
  final ValueNotifier<bool> allowScroll;

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  late final ScrollController _scrollController;
  late final ValueNotifier<int> _selectedCat;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _selectedCat = ValueNotifier(0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
        widget.onDrag(
          DragUpdateDetails(
            globalPosition: const Offset(0, 0),
            delta: const Offset(0, 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.allowScroll,
      builder: (context, allow, child) {
        return GestureDetector(
          onVerticalDragUpdate: allow
              ? null
              : (val) {
                  widget.onDrag(val);
                  _scrollController.animateTo(
                    _scrollController.position.pixels + 1,
                    duration: AppConfig.animationDuration,
                    curve: Curves.bounceIn,
                  );
                },
          child: Container(
            height: context.height * .85 - 70,
            width: context.width,
            decoration: const BoxDecoration(
              color: AppColors.scaffoldBackgroundColor,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: allow ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
              child: child,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          SectionHeader(
            title: serviceLocator<LocalizationClass>().appLocalizations!.categories,
            showTrailing: false,
          ),
          const SizedBox(height: 15),
          BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              return switch (context.read<RecipeCubit>().state.indexCategoriesStatus) {
                CubitStatus.loading => _buildCategoriesSkeltonLoading(),
                CubitStatus.success => _buildCategoriesListView(context, state),
                _ => MainErrorWidget(onTap: () => context.read<RecipeCubit>().indexCategories()).center(),
              };
            },
          ),
          const _Section(title: 'أحدث الوصفات', indexType: IndexType.newest),
          _Section(
            title: serviceLocator<LocalizationClass>().appLocalizations!.recommended,
            indexType: IndexType.newest, //TODO recommended
          ),
          const _Section(title: 'اهتماماتك', indexType: IndexType.followings),
          const _Section(title: 'الأكثر طلبَا', indexType: IndexType.trending),
          const _Section(title: 'الأعلى تقييما', indexType: IndexType.mostRated),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCategoriesSkeltonLoading() {
    return SizedBox(
      key: UniqueKey(),
      height: 75,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(end: 15),
        children: List.generate(
          6,
          (_) => const SkeltonLoading(
            height: 50,
            width: 110,
            padding: 12,
            margin: EdgeInsetsDirectional.only(start: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesListView(BuildContext context, RecipeState state) {
    return SizedBox(
      height: 75,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, value, child) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
              context.read<RecipeCubit>().indexRecipesBuyFollowings(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
              context.read<RecipeCubit>().indexRecipesMostRated(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
              context.read<RecipeCubit>().indexRecipesTrending(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(end: 15),
              itemCount: context.read<RecipeCubit>().state.categories.length,
              itemBuilder: (context, index) {
                return CategoryChoiceChip(
                  title: context.read<RecipeCubit>().state.categories[index].name!,
                  isActive: index == value,
                  onTap: () {
                    _selectedCat.value = index;

                    context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                          categoryId: index != 0 ? state.categories[index].id : null,
                        ));
                  },
                );
              },
            ),
          );
        },
      ).paddingVertical(10),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.indexType});

  final String title;
  final IndexType indexType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        SectionHeader(title: title),
        const SizedBox(height: 15),
        SizedBox(
          height: context.height * .25,
          child: BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              if (state.indexRecipeStatus == CubitStatus.loading) {
                return ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(start: 15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      width: context.width * .4,
                      height: context.height * .25,
                      child: const Icon(Icons.abc),
                    ),
                  ),
                );
              } else {
                switch (indexType) {
                  case IndexType.newest:
                    if (state.indexRecipeStatus == CubitStatus.success) {
                      return ListView.builder(
                        itemCount: state.recipes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCard(
                          recipe: state.recipes[index],
                          padding: const EdgeInsetsDirectional.only(start: 15),
                        ),
                      );
                    } else {
                      return MainErrorWidget(onTap: () {
                        context.read<RecipeCubit>().indexRecipes(const IndexRecipesParams());
                      });
                    }
                  case IndexType.followings:
                    if (state.indexByFollowingRecipeStatus == CubitStatus.success) {
                      return ListView.builder(
                        itemCount: state.followingsRecipes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCard(
                          recipe: state.followingsRecipes[index],
                          padding: const EdgeInsetsDirectional.only(start: 15),
                        ),
                      );
                    } else {
                      return MainErrorWidget(onTap: () {
                        context.read<RecipeCubit>().indexRecipesBuyFollowings(const IndexRecipesParams());
                      });
                    }
                  case IndexType.trending:
                    if (state.indexTrendingRecipeStatus == CubitStatus.success) {
                      return ListView.builder(
                        itemCount: state.trendingRecipes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCard(
                          recipe: state.trendingRecipes[index],
                          padding: const EdgeInsetsDirectional.only(start: 15),
                        ),
                      );
                    } else {
                      return MainErrorWidget(onTap: () {
                        context.read<RecipeCubit>().indexRecipesTrending(const IndexRecipesParams());
                      });
                    }
                  case IndexType.mostRated:
                    if (state.indexMostRatedRecipeStatus == CubitStatus.success) {
                      return ListView.builder(
                        itemCount: state.mostOrderedRecipes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCard(
                          recipe: state.mostOrderedRecipes[index],
                          padding: const EdgeInsetsDirectional.only(start: 15),
                        ),
                      );
                    } else {
                      return MainErrorWidget(onTap: () {
                        context.read<RecipeCubit>().indexRecipesMostRated(const IndexRecipesParams());
                      });
                    }
                  default:
                    return const SizedBox.shrink();
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
