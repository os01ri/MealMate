import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

import '../../domain/usecases/register_usecase.dart';
import '../bloc/register_bloc/register_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final RegisterBloc _registerBloc = RegisterBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MainAppBar(size: context.deviceSize, titleText: 'Create an Account'),
      body: BlocProvider(
        create: (context) => _registerBloc,
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) async {
            if (state.status == RegisterStatus.loading) {
              BotToast.showLoading();
            }
            if (state.status == RegisterStatus.success) {
              BotToast.closeAllLoading();
              context.go(Routes.accountCreationLoading);
            }
            if (state.status == RegisterStatus.failed) {
              BotToast.closeAllLoading();
              BotToast.showText(text: 'something went wrong');
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                      label: 'User Name',
                      hint: 'username',
                      validator: (text) {
                        if ((text != null && text.length < 3))
                          return "please add a valid username";
                        return null;
                      },
                      controller: userNameController),
                  Row(
                    children: [
                      Expanded(
                        child: AuthTextField(
                            hint: 'first name', label: 'First Name'),
                      ),
                      SizedBox(width: context.width * .05),
                      Expanded(
                        child: AuthTextField(
                            hint: 'last name', label: 'Last Name'),
                      ),
                    ],
                  ),
                  AuthTextField(
                      controller: emailController,
                      hint: 'you@example.com',
                      validator: (text) {
                        if (text != null && text.isValidEmail()) {
                          return null;
                        }
                        return "please add a valid email";
                      },
                      label: 'E-mail'),
                  AuthTextField(
                      label: 'Password',
                      validator: (text) {
                        if (text != null && text.isValidPassword()) {
                          return null;
                        }
                        return "please add a valid password";
                      },
                      controller: passwordController,
                      isPassword: true,
                      hint: '********'),
                  AuthTextField(
                      label: 'Confirm Password',
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (text) {
                        if (text != null && text == passwordController.text) {
                          return null;
                        } else
                          return "password dosen't match";
                      },
                      hint: '********'),
                  const SizedBox(height: 20),
                  MainButton(
                    text: 'Sign Up',
                    color: AppColors.mainColor,
                    width: context.width,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _registerBloc.add(RegisterUserEvent(
                          params: RegitserUserParams(
                              email: emailController.text,
                              userName: userNameController.text,
                              password: passwordController.text),
                        )); // context.go(Routes.otpScreen);
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: const Text('or Login'),
                      onPressed: () {
                        context.go(Routes.loginNamedPage);
                      },
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'By continuing you agree to the\n',
                      style: AppTextStyles.styleWeight400(color: Colors.grey),
                      children: [
                        TextSpan(
                            text: 'Terms of Services',
                            style: AppTextStyles.styleWeight600(
                                color: AppColors.mainColor)),
                        const TextSpan(text: ' & '),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.styleWeight600(
                                color: AppColors.mainColor))
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
}
