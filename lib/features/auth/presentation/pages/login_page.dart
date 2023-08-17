import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/features/welcoming/presentation/cubit/user_cubit.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/validation_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/main_app_bar.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../domain/usecases/login_usecase.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../widgets/auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _rememberMe;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _rememberMe = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        leadingWidget: const SizedBox(),
        titleText: serviceLocator<LocalizationClass>().appLocalizations!.login,
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _listener,
          builder: (BuildContext context, AuthState state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Text(
                      'Meal Mate',
                      style: const TextStyle(
                        color: AppColors.mainColor,
                        fontFamily: 'Pacifico',
                        fontSize: 50,
                      ).extraBold,
                    ).center(),
                  ),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.username,
                    icon: Icons.person,
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.pleaseEnterUsername,
                    controller: _userNameController,
                    validator: (text) {
                      return null;
                    },
                  ),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.password,
                    hint: '********',
                    icon: Icons.lock,
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
                        valueListenable: _rememberMe,
                        builder: (context, save, _) {
                          return Checkbox(
                            value: save,
                            activeColor: AppColors.mainColor,
                            onChanged: (value) {
                              _rememberMe.value = value!;
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
                      Helper.setNotFirstTimeOpeningApp();
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(LoginUserParams(
                              email: _userNameController.text,
                              password: _passwordController.text,
                            ));
                      }
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColors.mainColor)),
                    onPressed: () => context.myPushNamed(RoutesNames.forgotPassword),
                    child: Text(serviceLocator<LocalizationClass>().appLocalizations!.forgotPassword),
                  ),
                  /*const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(serviceLocator<LocalizationClass>().appLocalizations!.orContinueWith),
                      const SizedBox(height: 5),
                      MainButton(
                        text: 'Google',
                        color: Colors.red,
                        width: context.width,
                        onPressed: () {
                          Helper.setNotFirstTimeOpeningApp();
                        },
                      ),
                      const SizedBox(height: 10),
                      MainButton(
                        text: 'Facebook',
                        color: Colors.blue,
                        width: context.width,
                        onPressed: () => Helper.setNotFirstTimeOpeningApp(),
                      ),
                    ],
                  ),*/
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: Text(serviceLocator<LocalizationClass>().appLocalizations!.dontHaveAccount),
                      onPressed: () => context.myGoNamed(RoutesNames.signup),
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
      serviceLocator<UserCubit>().setUser(state.user!);
      Helper.setWillSaveToken(_rememberMe.value);
      Helper.setToken(state.user!.tokenInfo!.token!);
      Toaster.closeLoading();
      context.myGoNamed((RoutesNames.accountCreationLoading));
      log('logged in successfully...');
    } else if (state.status == AuthStatus.failed) {
      Toaster.closeLoading();
      Toaster.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    }
  }
}
