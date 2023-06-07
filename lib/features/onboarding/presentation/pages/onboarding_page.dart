import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/helper/helper_functions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/custom_intro_paint.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/intro_indicator.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/slide.dart';
import 'package:mealmate/router/app_routes.dart';

class OnboardingPage extends StatelessWidget {
  final List<Widget> _pages = [
    Slide(
      placeImage: true,
      image: Image.asset(
        SvgPath.intro1,
      ),
    ),
    Slide(
      placeImage: true,
      image: Image.asset(SvgPath.intro2),
    ),
    Slide(
      placeImage: false,
      image: Image.asset(SvgPath.intro3),
    )
  ];
  final List<Map<String, String>> texts = [
    {'title': 'Order Ingredients', 'description': 'Order the ingredients you need quickly with a fast process'},
    {'title': 'Let\'s Cooking', 'description': 'Cooking based on the food recipes you find and  the food you love'},
    {'title': 'All recipes you needed', 'description': '5000+ healthy recipes made by people for your healthy life'}
  ];

  OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Intro(
      pages: _pages,
      texts: texts,
      isCircle: true,
    );
  }
}

class Intro extends StatefulWidget {
  final List<Widget> pages;
  final List texts;

  final bool isCircle;

  const Intro({
    Key? key,
    required this.pages,
    required this.texts,
    required this.isCircle,
  }) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late final ValueNotifier<int> _selectedItem;
  late final PageController _controllerPageView;

  @override
  void initState() {
    _selectedItem = ValueNotifier(0);
    _controllerPageView = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerPageView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange.withOpacity(1),
      body: SafeArea(
        child: CustomPaint(
          painter: RPSCustomPainter(),
          size: context.deviceSize,
          child: ValueListenableBuilder(
            valueListenable: _selectedItem,
            builder: (context, value, child) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: value != widget.pages.length - 1
                          ? TextButton(
                              onPressed: () {
                                _controllerPageView.animateToPage(
                                  widget.pages.length,
                                  duration: AppConfig.pageViewAnimationDuration,
                                  curve: Curves.ease,
                                );
                              },
                              style: const ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(AppColors.deepOrange),
                                splashFactory: InkRipple.splashFactory,
                              ),
                              child: const Text('Skip'),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controllerPageView,
                      onPageChanged: (index) {
                        _selectedItem.value = index;
                        if (index > widget.pages.length - 2) {}
                      },
                      children: widget.pages,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IntroIndicator(
                      isCircle: widget.isCircle,
                      index: value,
                      pageNumber: widget.pages.length,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: IntroBottomContainer(
                      title: widget.texts[value]['title'],
                      buttonText: value != widget.pages.length - 1 ? 'next' : 'Get Started',
                      description: widget.texts[value]['description'],
                      onPressed: () async {
                        _controllerPageView.animateToPage(
                          _selectedItem.value + 1,
                          duration: AppConfig.pageViewAnimationDuration,
                          curve: Curves.ease,
                        );
                        await HelperFunctions.isFirstTime();
                        if (_controllerPageView.page!.ceil() == widget.pages.length - 1) {
                          context.go(AppRoutes.login);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class IntroBottomContainer extends StatelessWidget {
  const IntroBottomContainer({
    super.key,
    required this.description,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  final String title;
  final String buttonText;
  final String description;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: AppTextStyles.styleWeight700(fontSize: 20)),
          Text(
            description,
            style: AppTextStyles.styleWeight400(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          MainButton(
            width: MediaQuery.of(context).size.width,
            text: buttonText,
            color: AppColors.mainColor,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
