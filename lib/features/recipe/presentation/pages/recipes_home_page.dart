import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import '../../../control_panel/presentation/cubit/control_panel_cubit/control_panel_cubit.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
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

  static double _searchButtonUpPosition(BuildContext context) =>
      60; //context.height * .06;
  static double _searchButtonDownPosition(BuildContext context) =>
      context.height * .29;

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
      padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: context.height * .07),
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
          Text(
            '${serviceLocator<LocalizationClass>().appLocalizations!.hello} ${serviceLocator<ControlPanelCubit>().state.user!.name!.split(' ').first}!',
            style: const TextStyle(color: Colors.white).semiBold.xLargeFontSize,
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: _allowScroll.value ? Colors.transparent : Colors.white,
              fontFamily: 'Almarai',
            ).bold.xxLargeFontSize,
            child: Text(serviceLocator<LocalizationClass>()
                .appLocalizations!
                .whatToCook),
          ),
          SizedBox(height: context.height * .22),
        ],
      ).paddingVertical(10),
    ).positioned(top: 0);
  }

  _buildSearchButton(BuildContext context) {
    final isDown =
        (_searchButtonPosition.value == _searchButtonDownPosition(context));
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
                    serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .searchRecipes,
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
        ..indexRecipesByFollowings(const IndexRecipesParams()),
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
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
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
              physics: allow
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: child,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          SectionHeader(
            recipes: const [],
            title: serviceLocator<LocalizationClass>()
                .appLocalizations!
                .categories,
            showTrailing: false,
          ),
          const SizedBox(height: 10),
          BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              return switch (
                  context.read<RecipeCubit>().state.indexCategoriesStatus) {
                CubitStatus.loading => _buildCategoriesSkeltonLoading(),
                CubitStatus.success => _buildCategoriesListView(context, state),
                _ => MainErrorWidget(
                    onTap: () =>
                        context.read<RecipeCubit>().indexCategories()).center(),
              };
            },
          ),
          _Section(
            title: serviceLocator<LocalizationClass>()
                .appLocalizations!
                .newRecipes,
            indexType: IndexType.newest,
          ),
          _Section(
            title: serviceLocator<LocalizationClass>()
                .appLocalizations!
                .recommended,
            indexType: IndexType.newest, //TODO recommended
          ),
          _Section(
              title: serviceLocator<LocalizationClass>()
                  .appLocalizations!
                  .yourInterests,
              indexType: IndexType.followings),
          _Section(
            title:
                serviceLocator<LocalizationClass>().appLocalizations!.trending,
            indexType: IndexType.trending,
          ),
          _Section(
            title:
                serviceLocator<LocalizationClass>().appLocalizations!.mostRated,
            indexType: IndexType.mostRated,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCategoriesSkeltonLoading() {
    return SizedBox(
      key: UniqueKey(),
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(end: 15),
        children: List.generate(
          6,
          (index) => SkeltonLoading(
            height: 50,
            width: 110,
            // padding: 12,
            margin:
                EdgeInsetsDirectional.only(start: index == 0 ? 30 : 0, end: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesListView(BuildContext context, RecipeState state) {
    return SizedBox(
      height: 45,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedCat,
        builder: (context, value, child) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
              context
                  .read<RecipeCubit>()
                  .indexRecipesByFollowings(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
              context
                  .read<RecipeCubit>()
                  .indexRecipesMostRated(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
              context
                  .read<RecipeCubit>()
                  .indexRecipesTrending(IndexRecipesParams(
                    categoryId: value != 0 ? state.categories[value].id : null,
                  ));
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: context.read<RecipeCubit>().state.categories.length,
              itemBuilder: (context, index) {
                return CategoryChoiceChip(
                  title:
                      context.read<RecipeCubit>().state.categories[index].name!,
                  margin: EdgeInsetsDirectional.only(
                      start: index == 0 ? 30 : 0, end: 15),
                  isActive: index == value,
                  onTap: () {
                    _selectedCat.value = index;
                    context.read<RecipeCubit>().indexRecipes(IndexRecipesParams(
                          categoryId:
                              value != 0 ? state.categories[value].id : null,
                        ));
                    context
                        .read<RecipeCubit>()
                        .indexRecipesByFollowings(IndexRecipesParams(
                          categoryId:
                              value != 0 ? state.categories[value].id : null,
                        ));
                    context
                        .read<RecipeCubit>()
                        .indexRecipesMostRated(IndexRecipesParams(
                          categoryId:
                              value != 0 ? state.categories[value].id : null,
                        ));
                    context
                        .read<RecipeCubit>()
                        .indexRecipesTrending(IndexRecipesParams(
                          categoryId:
                              value != 0 ? state.categories[value].id : null,
                        ));
                  },
                );
              },
            ),
          );
        },
      ),
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
        const SizedBox(height: 15),
        BlocBuilder<RecipeCubit, RecipeState>(
          builder: (context, state) {
            return SectionHeader(
              title: title,
              allowTap: (indexType == IndexType.newest &&
                      state.indexRecipeStatus == CubitStatus.success) ||
                  (indexType == IndexType.followings &&
                      state.indexByFollowingRecipeStatus ==
                          CubitStatus.success) ||
                  (indexType == IndexType.mostRated &&
                      state.indexMostRatedRecipeStatus ==
                          CubitStatus.success) ||
                  (indexType == IndexType.trending &&
                      state.indexTrendingRecipeStatus == CubitStatus.success),
              recipes: switch (indexType) {
                IndexType.newest => state.recipes,
                IndexType.mostRated => state.mostRatedRecipes,
                IndexType.followings => state.followingsRecipes,
                IndexType.trending => state.trendingRecipes,
              },
            );
          },
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: context.height * .25,
          child: BlocBuilder<RecipeCubit, RecipeState>(
            builder: (context, state) {
              switch (indexType) {
                case IndexType.newest:
                  if (state.indexRecipeStatus == CubitStatus.success) {
                    return _buildRecipeListView(state.recipes, context);
                  } else if (state.indexRecipeStatus == CubitStatus.loading) {
                    return _buildLoadingListView();
                  } else {
                    return _handleErrorTap(context);
                  }
                case IndexType.followings:
                  if (state.indexByFollowingRecipeStatus ==
                      CubitStatus.success) {
                    return _buildRecipeListView(
                        state.followingsRecipes, context);
                  } else if (state.indexByFollowingRecipeStatus ==
                      CubitStatus.loading) {
                    return _buildLoadingListView();
                  } else {
                    return _handleErrorTap(context);
                  }
                case IndexType.trending:
                  if (state.indexTrendingRecipeStatus == CubitStatus.success) {
                    return _buildRecipeListView(state.trendingRecipes, context);
                  } else if (state.indexTrendingRecipeStatus ==
                      CubitStatus.loading) {
                    return _buildLoadingListView();
                  } else {
                    return _handleErrorTap(context);
                  }
                case IndexType.mostRated:
                  if (state.indexMostRatedRecipeStatus == CubitStatus.success) {
                    return _buildRecipeListView(
                        state.mostRatedRecipes, context);
                  } else if (state.indexMostRatedRecipeStatus ==
                      CubitStatus.loading) {
                    return _buildLoadingListView();
                  } else {
                    return _handleErrorTap(context);
                  }
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) => SkeltonLoading(
        width: context.width * .43,
        height: context.height * .25,
        margin: EdgeInsetsDirectional.only(start: index == 0 ? 30 : 0, end: 15),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildRecipeListView(List<RecipeModel> recipes, BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => RecipeCard(
        recipe: recipes[index],
        padding:
            EdgeInsetsDirectional.only(start: index == 0 ? 30 : 0, end: 15),
      ),
    );
  }

  Widget _handleErrorTap(BuildContext context) {
    if (indexType == IndexType.newest) {
      return MainErrorWidget(onTap: () {
        context.read<RecipeCubit>().indexRecipes(const IndexRecipesParams());
      });
    } else if (indexType == IndexType.followings) {
      return MainErrorWidget(onTap: () {
        context
            .read<RecipeCubit>()
            .indexRecipesByFollowings(const IndexRecipesParams());
      });
    } else if (indexType == IndexType.trending) {
      return MainErrorWidget(onTap: () {
        context
            .read<RecipeCubit>()
            .indexRecipesTrending(const IndexRecipesParams());
      });
    } else if (indexType == IndexType.mostRated) {
      return MainErrorWidget(onTap: () {
        context
            .read<RecipeCubit>()
            .indexRecipesTrending(const IndexRecipesParams());
      });
    } else {
      throw UnimplementedError('IndexType $indexType not implemented');
    }
  }
}
