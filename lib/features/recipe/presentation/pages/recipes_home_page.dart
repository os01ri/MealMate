import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/features/recipe/presentation/widgets/category_choice_chip.dart';
import 'package:mealmate/features/recipe/presentation/widgets/section_header.dart';
import 'package:mealmate/injection_container.dart';
import 'package:mealmate/router/app_routes.dart';

part '../widgets/recipe_card.dart';

class RecipesHomePage extends StatefulWidget {
  const RecipesHomePage({super.key});

  @override
  State<RecipesHomePage> createState() => _RecipesHomePageState();
}

class _RecipesHomePageState extends State<RecipesHomePage> {
  late final ValueNotifier<double> _bodyPosition;
  late final ValueNotifier<double> _searchButtonPosition;
  late final ValueNotifier<bool> _allowScroll;

  static double _bodyUpPosition(BuildContext context) => context.height * .15;
  static double _bodyDownPosition(BuildContext context) => context.height * .38;

  static double _searchButtonUpPosition(BuildContext context) => context.height * .06;
  static double _searchButtonDownPosition(BuildContext context) => context.height * .29;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allowScroll = ValueNotifier(false);
    _bodyPosition = ValueNotifier(_bodyDownPosition(context));
    _searchButtonPosition = ValueNotifier(_searchButtonDownPosition(context));
  }

  _buildOrangeContainer(BuildContext context) {
    return Container(
      height: context.height * .6,
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: context.height * .08),
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
            '${serviceLocator<LocalizationClass>().appLocalizations!.hello} Osama!',
            style: const TextStyle(color: Colors.white).semiBold.xLargeFontSize,
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(color: _allowScroll.value ? Colors.transparent : Colors.white).bold.xxLargeFontSize,
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
                  style: TextStyle(fontSize: isDown ? 14 : 0, color: Colors.black),
                  child: Text(
                    serviceLocator<LocalizationClass>().appLocalizations!.searchRecipes,
                  ).paddingHorizontal(10),
                ),
              ),
            ],
          ),
        ),
      ),
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
    return Scaffold(
      body: Stack(
        children: [
          _buildOrangeContainer(context),
          _buildSearchButton(context),
          _buildBody(context),
        ],
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
          SectionHeader(title: serviceLocator<LocalizationClass>().appLocalizations!.categories),
          const SizedBox(height: 15),
          Row(
            children: [
              const CategoryChoiceChip(title: 'الإفطار', isActive: true),
              for (int i = 0; i < 10; i++) const CategoryChoiceChip(title: 'العشاء', isActive: false),
            ],
          ).scrollable(scrollDirection: Axis.horizontal),
          for (int i = 10; i <= 50; i += 10) ...[
            const SizedBox(height: 25),
            SectionHeader(title: serviceLocator<LocalizationClass>().appLocalizations!.recommended),
            const SizedBox(height: 15),
            SizedBox(
              height: context.height * .25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  5,
                  (index) => _RecipeCard(index: ((index + 1) * 10 * (i + 1))),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
