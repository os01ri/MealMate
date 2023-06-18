import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/helper.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/ui_messages.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/auth/domain/usecases/register_usecase.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/pages/otp_page.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/routes_names.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _userNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        leadingWidget: const SizedBox(),
        titleText: serviceLocator<LocalizationClass>().appLocalizations!.createAccount,
      ),
      body: BlocProvider(
        create: (_) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _listener,
          builder: (BuildContext context, AuthState state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                    icon: Icons.person,
                    label: serviceLocator<LocalizationClass>().appLocalizations!.username,
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.username,
                    validator: (text) {
                      if ((text != null && text.length < 3)) {
                        return serviceLocator<LocalizationClass>().appLocalizations!.addValidUsername;
                      }
                      return null;
                    },
                    controller: _userNameController,
                  ),
                  Row(
                    children: [
                      AuthTextField(
                        icon: Icons.offline_bolt_rounded,
                        hint: serviceLocator<LocalizationClass>().appLocalizations!.firstName,
                        label: serviceLocator<LocalizationClass>().appLocalizations!.username,
                        controller: _firstNameController,
                      ).expand(),
                      SizedBox(width: context.width * .05),
                      AuthTextField(
                        icon: Icons.offline_bolt_rounded,
                        hint: serviceLocator<LocalizationClass>().appLocalizations!.lastName,
                        label: serviceLocator<LocalizationClass>().appLocalizations!.lastName,
                        controller: _lastNameController,
                      ).expand(),
                    ],
                  ),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.email,
                    hint: 'you@example.com',
                    icon: Icons.email,
                    controller: _emailController,
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      }
                      return serviceLocator<LocalizationClass>().appLocalizations!.enterValidEmail;
                    },
                  ),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.password,
                    hint: '********',
                    isPassword: true,
                    icon: Icons.lock,
                    controller: _passwordController,
                    validator: (text) {
                      if (text != null && text.isValidPassword()) {
                        return null;
                      }
                      return serviceLocator<LocalizationClass>().appLocalizations!.enterValidPassword;
                    },
                  ),
                  AuthTextField(
                    icon: Icons.lock,
                    label: serviceLocator<LocalizationClass>().appLocalizations!.confirmPassword,
                    controller: _confirmPasswordController,
                    isPassword: true,
                    validator: (text) {
                      if (text != null && text == _passwordController.text) {
                        return null;
                      } else {
                        return serviceLocator<LocalizationClass>().appLocalizations!.passwordNotMatch;
                      }
                    },
                    hint: '********',
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    text: serviceLocator<LocalizationClass>().appLocalizations!.signUp,
                    color: AppColors.mainColor,
                    width: context.width,
                    onPressed: () {
                      Helper.setNotFirstTimeOpeningApp();
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                              RegisterUserParams(
                                name:
                                    "${_firstNameController.text} ${_lastNameController.text}",
                                email: _emailController.text,
                                userName: _userNameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: Text(serviceLocator<LocalizationClass>().appLocalizations!.orLogin),
                      onPressed: () {
                        context.goNamed(RoutesNames.login);
                      },
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'By continuing you agree to the\n',
                      style: AppTextStyles.styleWeight400(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: serviceLocator<LocalizationClass>().appLocalizations!.termsOfService,
                          style: AppTextStyles.styleWeight600(color: AppColors.mainColor),
                        ),
                        TextSpan(text: serviceLocator<LocalizationClass>().appLocalizations!.and),
                        TextSpan(
                          text: serviceLocator<LocalizationClass>().appLocalizations!.privacyPolicy,
                          style: AppTextStyles.styleWeight600(color: AppColors.mainColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ).padding(AppConfig.pagePadding).scrollable(),
    );
  }

  void _listener(BuildContext context, AuthState state) {
    if (state.status == AuthStatus.loading) {
      Toaster.showLoading();
    } else if (state.status == AuthStatus.success) {
      Toaster.closeLoading();
      log("${state.user!.tokenInfo!.token!}");
      Helper.setUserToken(state.user!.tokenInfo!.token!);
      context.goNamed(RoutesNames.otp,
          extra: OtpPageParams(
              email: _emailController.text, authCubit: AuthCubit()));
    } else if (state.status == AuthStatus.failed) {
      Toaster.closeLoading();
      Toaster.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    }
  }
}
