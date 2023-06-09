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
import 'package:mealmate/core/ui/ui_messages.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/domain/usecases/login_usecase.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/router/routes_names.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthCubit _loginCubit = AuthCubit();

  final ValueNotifier<bool> _saveLogin = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        titleText: serviceLocator<LocalizationClass>().appLocalizations!.login,
      ),
      body: BlocProvider(
        create: (context) => _loginCubit,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _cubitListener,
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.email,
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.enterEmail,
                    controller: _emailController,
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      } else {
                        return serviceLocator<LocalizationClass>().appLocalizations!.enterValidEmail;
                      }
                    },
                  ),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.password,
                    hint: '********',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (text) {
                      if (text != null && text.isValidPassword()) {
                        return null;
                      } else {
                        return serviceLocator<LocalizationClass>().appLocalizations!.enterValidPassword;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _saveLogin,
                        builder: (context, save, _) {
                          return Checkbox(
                            value: save,
                            activeColor: AppColors.mainColor,
                            onChanged: (value) {
                              _saveLogin.value = value!;
                            },
                          );
                        },
                      ),
                      Text(serviceLocator<LocalizationClass>().appLocalizations!.stayLoggedIn),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    text: serviceLocator<LocalizationClass>().appLocalizations!.login,
                    color: AppColors.mainColor,
                    width: context.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginCubit.login(LoginUserParams(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                      }
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColors.mainColor)),
                    onPressed: () => context.pushNamed(RoutesNames.forgotPassword),
                    child: Text(serviceLocator<LocalizationClass>().appLocalizations!.forgotPassword),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(serviceLocator<LocalizationClass>().appLocalizations!.orContinueWith),
                      const SizedBox(height: 5),
                      MainButton(
                        text: 'Google',
                        color: Colors.red,
                        width: context.width,
                        onPressed: () => context.goNamed(RoutesNames.recipesHome),
                      ),
                      const SizedBox(height: 10),
                      MainButton(
                        text: 'Facebook',
                        color: Colors.blue,
                        width: context.width,
                        onPressed: () => context.goNamed(RoutesNames.recipesHome),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: Text(serviceLocator<LocalizationClass>().appLocalizations!.dontHaveAccount),
                      onPressed: () => context.goNamed(RoutesNames.signup),
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

  void _cubitListener(BuildContext context, AuthState state) async {
    if (state.status == AuthStatus.loading) {
      UiMessages.showLoading();
    } else if (state.status == AuthStatus.success) {
      if (_saveLogin.value) await Helper.setUserDataToStorage(state.user!);
      Helper.setUserToken(state.user!.tokenInfo!.token!);
      UiMessages.closeLoading();
      context.goNamed((RoutesNames.accountCreationLoading));
      log('logged in successfully');
    } else if (state.status == AuthStatus.failed) {
      UiMessages.closeLoading();
      UiMessages.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    }
  }
}
