import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/helper_functions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/ui_messages.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/domain/usecases/login_usecase.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthCubit _loginCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(size: context.deviceSize, titleText: 'Login'),
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
                    label: 'E-mail Address',
                    hint: 'Enter E-mail Address',
                    controller: _emailController,
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      } else {
                        return "please add a valid email";
                      }
                    },
                  ),
                  AuthTextField(
                    label: 'Password',
                    hint: '********',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (text) {
                      if (text != null && text.isValidPassword()) {
                        return null;
                      } else {
                        return "password isn't valid";
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    text: 'Login',
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
                    onPressed: () => context.push(AppRoutes.forgotPassword),
                    child: const Text('Forgot Password?'),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Text('or continue with'),
                      const SizedBox(height: 5),
                      MainButton(
                        text: 'Login With Google',
                        color: AppColors.mainColor,
                        width: context.width,
                        onPressed: () => context.go(AppRoutes.recipesHome),
                      ),
                      const SizedBox(height: 10),
                      MainButton(
                        text: 'Login With Facebook',
                        color: Colors.blue,
                        width: context.width,
                        onPressed: () => context.go(AppRoutes.recipesHome),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: const Text('Don\'t ave an account? Sign Up'),
                      onPressed: () => context.go(AppRoutes.signup),
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

  void _cubitListener(context, state) async {
    if (state.status == AuthStatus.loading) {
      UiMessages.showLoading();
    } else if (state.status == AuthStatus.success) {
      await HelperFunctions.setUserData(state.user!);
      UiMessages.closeLoading();
      context.go(AppRoutes.accountCreationLoading);
      log('loged in successfuly');
    } else if (state.status == AuthStatus.failed) {
      UiMessages.closeLoading();
      UiMessages.showToast('something went wrong');
    }
  }
}
