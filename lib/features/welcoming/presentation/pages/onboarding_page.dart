import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../widgets/custom_intro_paint.dart';
import '../widgets/intro_indicator.dart';
import '../widgets/slide.dart';

const _titleKey = 'title';
const _descriptionKey = 'description';

class OnboardingPage extends StatelessWidget {
  final List<Widget> _pages = [
    Slide(
      placeImage: true,
      image: Image.asset(
        PngPath.intro1,
      ),
    ),
    Slide(
      placeImage: true,
      image: Image.asset(PngPath.intro2),
    ),
    Slide(
      placeImage: false,
      image: Image.asset(PngPath.intro3),
    )
  ];

  final List<Map<String, String>> _texts = [
    {
      _titleKey: serviceLocator<LocalizationClass>()
          .appLocalizations!
          .onboardingTitle1,
      _descriptionKey: serviceLocator<LocalizationClass>()
          .appLocalizations!
          .onboardingDescription1,
    },
    {
      _titleKey: serviceLocator<LocalizationClass>()
          .appLocalizations!
          .onboardingTitle2,
      _descriptionKey: serviceLocator<LocalizationClass>()
          .appLocalizations!
          .onboardingDescription2,
    },
    {
      _titleKey: serviceLocator<LocalizationClass>()
          .appLocalizations!
          .onboardingTitle3,
      _descriptionKey: serviceLocator<LocalizationClass>()
          .appLocalizations!
          .onboardingDescription3,
    }
  ];

  OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Intro(
      pages: _pages,
      texts: _texts,
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
          painter: const RPSCustomPainter(),
          size: context.deviceSize,
          child: ValueListenableBuilder(
            valueListenable: _selectedItem,
            builder: (context, value, child) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
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
                                foregroundColor: MaterialStatePropertyAll(
                                  AppColors.deepOrange,
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xc0ffffff)),
                                splashFactory: InkRipple.splashFactory,
                              ),
                              child: Text(serviceLocator<LocalizationClass>()
                                  .appLocalizations!
                                  .skip),
                            ).paddingHorizontal(10)
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
                      title: widget.texts[value][_titleKey],
                      buttonText: value != widget.pages.length - 1
                          ? serviceLocator<LocalizationClass>()
                              .appLocalizations!
                              .next
                          : serviceLocator<LocalizationClass>()
                              .appLocalizations!
                              .getStarted,
                      description: widget.texts[value][_descriptionKey],
                      onPressed: () async {
                        _controllerPageView.animateToPage(
                          _selectedItem.value + 1,
                          duration: AppConfig.pageViewAnimationDuration,
                          curve: Curves.ease,
                        );
                        await Helper.isFirstTimeOpeningApp();
                        if (_controllerPageView.page!.ceil() ==
                            widget.pages.length - 1) {
                          if (context.mounted) {
                            context.myGoNamed(RoutesNames.login);
                          }
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
