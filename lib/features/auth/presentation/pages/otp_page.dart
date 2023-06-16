// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/helper.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/widgets/numerical_keyboard.dart';
import 'package:mealmate/router/routes_names.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.args});

  final OtpPageParams args;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _controller;
  late final ValueNotifier<String> _otpController;
  late final ValueNotifier<int> seconds;
  late final Timer timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    seconds.value = 30;
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds.value == 0) {
          timer.cancel();
        } else {
          seconds.value--;
        }
      },
    );
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    seconds = ValueNotifier(10);
    _otpController = ValueNotifier('');
    _controller = TextEditingController();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final willPop = await _showConfirmationDialog(context);
        if (willPop && !widget.args.isResetPassword) {
          if (context.mounted) context.goNamed(RoutesNames.splash);
        }
        return Future.value(willPop);
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: widget.args.authCubit,
        listener: _listener,
        builder: (BuildContext context, AuthState state) {
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
                          Text(
                            state.email!,
                            style: AppTextStyles.styleWeight500(
                              fontSize: 22,
                              color: AppColors.mainColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(height: context.height * .04),
                          Form(
                            key: _formKey,
                            child: ValueListenableBuilder(
                              valueListenable: _otpController,
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
                                        validator: (text) => text == null || text.isEmpty ? "" : null,
                                        width: context.width * .13,
                                        textAlign: TextAlign.center,
                                      ),
                                      MainTextField(
                                        validator: (text) => text == null || text.isEmpty ? "" : null,
                                        controller: TextEditingController(text: value.length > 1 ? value[1] : ''),
                                        enabled: false,
                                        width: context.width * .13,
                                        textAlign: TextAlign.center,
                                      ),
                                      MainTextField(
                                        validator: (text) => text == null || text.isEmpty ? "" : null,
                                        controller: TextEditingController(text: value.length > 2 ? value[2] : ''),
                                        enabled: false,
                                        width: context.width * .13,
                                        textAlign: TextAlign.center,
                                      ),
                                      MainTextField(
                                        validator: (text) => text == null || text.isEmpty ? "" : null,
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
                          ),
                          //TODO
                          // Directionality(
                          //   textDirection: TextDirection.ltr,
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: context.width * .145),
                          //     child: const Row(),
                          //   ),
                          // ),
                          SizedBox(height: context.width * .05),
                          ValueListenableBuilder(
                            valueListenable: seconds,
                            builder: (context, time, _) {
                              return Text.rich(
                                TextSpan(
                                  text: serviceLocator<LocalizationClass>().appLocalizations!.codeNotSent,
                                  style: AppTextStyles.styleWeight500(fontSize: 20),
                                  children: [
                                    time == 0
                                        ? TextSpan(
                                            text: serviceLocator<LocalizationClass>().appLocalizations!.resendCode,
                                            style: AppTextStyles.styleWeight500(
                                                color: Theme.of(context).primaryColor, fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                widget.args.authCubit.sendOtpCode(state.email!);
                                                startTimer();
                                              },
                                          )
                                        : TextSpan(
                                            text: "00:${time.toString().padLeft(2, "0")}",
                                            style: AppTextStyles.styleWeight500(
                                                color: Theme.of(context).primaryColor, fontSize: 16),
                                          )
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: context.width * .05),
                          if (widget.args.isResetPassword)
                            GestureDetector(
                              onTap: () async {
                                await _showConfirmationDialog(context).then((value) {
                                  if (value) context.pop();
                                });
                              },
                              child: Text(
                                serviceLocator<LocalizationClass>().appLocalizations!.changeEmail,
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
                              textEditingController: _controller,
                              size: context.deviceSize,
                              value: _otpController,
                              maxLength: 4,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.args.authCubit.checkOtpCode(
                                    _otpController.value,
                                    !widget.args.isResetPassword,
                                  );
                                }
                              },
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
        },
      ),
    );
  }

  void _listener(BuildContext context, AuthState state) {
    if (state.status == AuthStatus.loading) {
      BotToast.showLoading();
    } else if (state.status == AuthStatus.success) {
      Helper.setUserToken(state.token!);
      BotToast.closeAllLoading();
      context.goNamed(
        widget.args.isResetPassword ? RoutesNames.changePassword : RoutesNames.accountCreationLoading,
      );
    } else if (state.status == AuthStatus.failed) {
      BotToast.closeAllLoading();
    }
  }

  Future<dynamic> _showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(serviceLocator<LocalizationClass>().appLocalizations!.areYouSure),
          actions: [
            MainButton(
              text: serviceLocator<LocalizationClass>().appLocalizations!.yes,
              color: AppColors.mainColor,
              onPressed: () => context.pop(true),
            ),
            MainButton(
              text: serviceLocator<LocalizationClass>().appLocalizations!.no,
              color: AppColors.mainColor,
              onPressed: () => context.pop(false),
            )
          ],
        );
      },
    );
  }
}

class OtpPageParams {
  final AuthCubit authCubit;
  final bool isResetPassword;

  const OtpPageParams({
    required this.authCubit,
    this.isResetPassword = false,
  });
}
