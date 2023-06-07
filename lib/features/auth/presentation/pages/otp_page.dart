import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/features/auth/presentation/widgets/numerical_keyboard.dart';
import 'package:mealmate/injection_container.dart';
import 'package:mealmate/router/app_routes.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late final TextEditingController controller;
  late final ValueNotifier<String> otpController;

  @override
  void initState() {
    super.initState();
    otpController = ValueNotifier('');
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(bottom: context.width * .025, child: const Icon(Icons.login)),
              Container(
                height: context.height,
                width: context.width,
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                child: Column(
                  children: [
                    SizedBox(height: context.height * .06),
                    Text(
                      serviceLocator<LocalizationClass>().appLocalizations!.enterOtpCode,
                      style: AppTextStyles.styleWeight600(fontSize: 24),
                    ),
                    SizedBox(height: context.height * .06),
                    Text(
                      serviceLocator<LocalizationClass>().appLocalizations!.enterOtpCode,
                      style: AppTextStyles.styleWeight500(fontSize: 16),
                    ),
                    SizedBox(height: context.height * .02),
                    const Text(
                      '+963932728290',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 22,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(height: context.height * .04),
                    ValueListenableBuilder(
                      valueListenable: otpController,
                      builder: (context, value, _) {
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainTextField(
                                controller: TextEditingController(text: value.isNotEmpty ? value[0] : ''),
                                enabled: false,
                                width: context.width * .13,
                                textAlign: TextAlign.center,
                              ),
                              MainTextField(
                                controller: TextEditingController(text: value.length > 1 ? value[1] : ''),
                                enabled: false,
                                width: context.width * .13,
                                textAlign: TextAlign.center,
                              ),
                              MainTextField(
                                controller: TextEditingController(text: value.length > 2 ? value[2] : ''),
                                enabled: false,
                                width: context.width * .13,
                                textAlign: TextAlign.center,
                              ),
                              MainTextField(
                                controller: TextEditingController(text: value.length > 3 ? value[3] : ''),
                                enabled: false,
                                width: context.width * .13,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.width * .145),
                        child: const Row(),
                      ),
                    ),
                    SizedBox(height: context.width * .05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        serviceLocator<LocalizationClass>().appLocalizations!.resendCode,
                        style: const TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: context.width * .05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        serviceLocator<LocalizationClass>().appLocalizations!.changePhoneNumber,
                        style: const TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * .035),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: NumericalKeyboard(
                        textEditingController: controller,
                        size: context.deviceSize,
                        value: otpController,
                        maxLength: 4,
                        onTap: () => context.go(AppRoutes.accountCreationLoading),
                      ),
                    ),
                  ],
                ),
              ).paddingHorizontal(context.width * .1),
            ],
          ),
        ),
      ),
    );
  }
}
