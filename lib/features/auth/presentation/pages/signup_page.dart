import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/ui_messages.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/domain/usecases/register_usecase.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final AuthCubit _registerCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(size: context.deviceSize, titleText: 'Create an Account'),
      body: BlocProvider(
        create: (context) => _registerCubit,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _cubitListener,
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                    label: 'User Name',
                    hint: 'username',
                    validator: (text) {
                      if ((text != null && text.length < 3)) return "please add a valid username";
                      return null;
                    },
                    controller: _userNameController,
                  ),
                  Row(
                    children: [
                      const AuthTextField(hint: 'first name', label: 'First Name').expand(),
                      SizedBox(width: context.width * .05),
                      const AuthTextField(hint: 'last name', label: 'Last Name').expand(),
                    ],
                  ),
                  AuthTextField(
                    controller: _emailController,
                    hint: 'you@example.com',
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      }
                      return "please add a valid email";
                    },
                    label: 'E-mail',
                  ),
                  AuthTextField(
                    label: 'Password',
                    validator: (text) {
                      if (text != null && text.isValidPassword()) {
                        return null;
                      }
                      return "please add a valid password";
                    },
                    controller: _passwordController,
                    isPassword: true,
                    hint: '********',
                  ),
                  AuthTextField(
                    label: 'Confirm Password',
                    controller: _confirmPasswordController,
                    isPassword: true,
                    validator: (text) {
                      if (text != null && text == _passwordController.text) {
                        return null;
                      } else {
                        return "password doesn't match";
                      }
                    },
                    hint: '********',
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    text: 'Sign Up',
                    color: AppColors.mainColor,
                    width: context.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _registerCubit.register(
                          RegisterUserParams(
                            email: _emailController.text,
                            userName: _userNameController.text,
                            password: _passwordController.text,
                          ),
                        ); // context.go(Routes.otpScreen);
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      child: const Text('or Login'),
                      onPressed: () {
                        context.go(AppRoutes.login);
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
                          style: AppTextStyles.styleWeight600(color: AppColors.mainColor),
                        ),
                        const TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
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

  void _cubitListener(context, state) async {
    if (state.status == AuthStatus.loading) {
      UiMessages.showLoading();
    }
    if (state.status == AuthStatus.success) {
      UiMessages.closeLoading();
      context.go(AppRoutes.accountCreationLoading);
    }
    if (state.status == AuthStatus.failed) {
      UiMessages.closeLoading();
      UiMessages.showToast('something went wrong');
    }
  }
}
