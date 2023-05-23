import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/helper_functions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/domain/usecases/login_usecase.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

import '../bloc/login_bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginBloc _loginBloc = LoginBloc();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        titleText: 'Login',
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state.status == LoginStatus.loading) {
              BotToast.showLoading();
            } else if (state.status == LoginStatus.success) {
              await HelperFunctions.setUserData(state.user!);
              BotToast.closeAllLoading();
              context.go(Routes.accountCreationLoading);
            }
            if (state.status == LoginStatus.failed) {
              BotToast.closeAllLoading();
              BotToast.showText(text: 'something went wrong');
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                    label: 'E-mail Address',
                    hint: 'Enter E-mail Address',
                    controller: emailController,
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
                    controller: passwordController,
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
                      if (formKey.currentState!.validate()) {
                        _loginBloc.add(LoginUserEvent(
                            body: LoginUserParams(
                                email: emailController.text,
                                password: passwordController.text)));
                      }
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(AppColors.mainColor)),
                    onPressed: () => context.push(Routes.forgotPasswordPage),
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
                        onPressed: () => context.go(Routes.recipesBrowsePage),
                      ),
                      const SizedBox(height: 10),
                      MainButton(
                        text: 'Login With Facebook',
                        color: Colors.blue,
                        width: context.width,
                        onPressed: () => context.go(Routes.recipesBrowsePage),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: const Text('Don\'t ave an account? Sign Up'),
                      onPressed: () => context.go(Routes.signUpNamedPage),
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
}
