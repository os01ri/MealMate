import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/ui/toaster.dart';
import 'package:mealmate/features/media_service/data/model/media_model.dart';
import 'package:mealmate/features/recipe/domain/usecases/rate_recipe_usecase.dart';
import 'package:mealmate/features/recipe/presentation/cubit/recipe_cubit.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../media_service/presentation/widgets/cache_network_image.dart';
import '../../data/models/recipe_step_model.dart';
import '../../domain/usecases/cook_recipe_usecase.dart';

class RecipeStepsPage extends StatelessWidget {
  const RecipeStepsPage({super.key, required this.screenParams});

  final StepsScreenParams screenParams;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: RecipeAppBar(
        //   context: context,
        //   title: 'Pasta Preparation',
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: Image.asset(
        //         PngPath.saveInactive,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        body: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CachedNetworkImage(
              width: context.width,
              height: context.height * .4,
              hash: screenParams.image.hash!,
              url: screenParams.image.mediaUrl!,
              fit: BoxFit.fitWidth,
            ).positioned(top: 0),
            _StepsSection(
              id: screenParams.recipeId,
              steps: screenParams.steps,
            ).positioned(bottom: 0),
          ],
        ),
      ),
    );
  }
}

class _StepsSection extends StatelessWidget {
  _StepsSection({required this.steps, required this.id});

  final int id;
  final List<RecipeStepModel> steps;
  final ValueNotifier<int> currentStep = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * .65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: currentStep,
        builder: (_, currentStepValue, child) {
          return Column(
            children: [
              Text(
                currentStepValue == steps.length
                    ? serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .recipeFinished
                    : '${serviceLocator<LocalizationClass>().appLocalizations!.step} ${currentStepValue + 1}',
                style: const TextStyle().bold.largeFontSize,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < steps.length; i++)
                    StepBullet(
                      isActive: i == currentStepValue,
                      stepNumber: i + 1,
                    ),
                  StepBullet(
                    isActive: currentStepValue == steps.length,
                    child: Icon(
                      Icons.flag_outlined,
                      color: currentStepValue == steps.length
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     //TODO!
              //     for (int i = 0; i < 0; i++) ...[
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'صدور الدجاج',
              //             style: const TextStyle().normalFontSize.semiBold,
              //           ),
              //           const Text(
              //             '250 غ',
              //             style: TextStyle(),
              //           ),
              //         ],
              //       ).paddingAll(8),
              //       const Divider(),
              //     ],
              //   ],
              // ),
              Text(
                currentStepValue < steps.length
                    ? steps[currentStepValue].description!
                    : serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .congratsOnFinishingThRecipe,
                style: const TextStyle().normalFontSize.regular,
              ).paddingVertical(15).scrollable().expand(),
              BlocProvider(
                create: (context) => RecipeCubit(),
                child: Builder(
                  builder: (context) {
                    return BlocListener<RecipeCubit, RecipeState>(
                      listener: (context, state) {
                        if (state.cookRecipeStatus == CubitStatus.loading) {
                          Toaster.showLoading();
                        } else if (state.cookRecipeStatus ==
                            CubitStatus.success) {
                          Toaster.closeLoading();

                          if (state.rateRecipeStatus == CubitStatus.initial) {
                            showRateDialog(context);
                          } else if (state.rateRecipeStatus ==
                              CubitStatus.loading) {
                            Toaster.showLoading();
                          } else if (state.rateRecipeStatus ==
                              CubitStatus.success) {
                            Toaster.closeLoading();
                            context.myPop();
                            context.myGoNamed(RoutesNames.recipesHome);
                            Toaster.showToast('شكرا لتقييمك للوصفة!');
                          } else if (state.rateRecipeStatus ==
                              CubitStatus.failure) {
                            Toaster.closeLoading();
                            Toaster.showToast('أعد المحاولة!');
                          }
                        } else if (state.cookRecipeStatus ==
                            CubitStatus.failure) {
                          Toaster.closeLoading();
                          Toaster.showToast('حدث خطأ، أعد المحاولة');
                        }
                      },
                      child: Row(
                        children: [
                          MainButton(
                            color: AppColors.grey,
                            onPressed: () {
                              if (currentStepValue == 0) {
                                context.myPop();
                              } else {
                                currentStep.value--;
                              }
                            },
                            text: currentStepValue == 0
                                ? serviceLocator<LocalizationClass>()
                                    .appLocalizations!
                                    .cancel
                                : serviceLocator<LocalizationClass>()
                                    .appLocalizations!
                                    .previous,
                            textColor: Colors.black,
                          ).paddingAll(8).expand(),
                          MainButton(
                            color: AppColors.mainColor,
                            onPressed: () {
                              if (currentStepValue == steps.length) {
                                context
                                    .read<RecipeCubit>()
                                    .cookRecipe(CookRecipeParams(id: id));
                              } else {
                                currentStep.value++;
                              }
                            },
                            text: currentStepValue == steps.length
                                ? serviceLocator<LocalizationClass>()
                                    .appLocalizations!
                                    .finishCooking
                                : serviceLocator<LocalizationClass>()
                                    .appLocalizations!
                                    .next,
                          ).hero('button').paddingAll(8).expand(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ).padding(AppConfig.pagePadding),
    );
  }

  showRateDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(borderRadius: AppConfig.borderRadius),
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'الرجاء تقييم الوصفة',
                  style: const TextStyle().bold.normalFontSize,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () => context.read<RecipeCubit>().rateRecipe(
                            RateRecipeParams(
                              id: id,
                              rate: index + 1,
                            ),
                          ),
                      icon: const Icon(
                        Icons.star_rate_outlined,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        color: isActive ? AppColors.mainColor : Colors.white,
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

class StepsScreenParams {
  final int recipeId;
  final MediaModel image;
  final List<RecipeStepModel> steps;

  const StepsScreenParams(
      {required this.recipeId, required this.image, required this.steps});
}
