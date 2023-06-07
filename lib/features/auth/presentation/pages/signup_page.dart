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
      appBar: MainAppBar(size: context.deviceSize, titleText: serviceLocator<LocalizationClass>().appLocalizations!.createAccount),
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
                    label: serviceLocator<LocalizationClass>().appLocalizations!.username,
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.username,
                    validator: (text) {
                      if ((text != null && text.length < 3)) 
                        return serviceLocator<LocalizationClass>().appLocalizations!.addValidUsername;
                      return null;
                    },
                    controller: _userNameController,
                  ),
                  Row(
                    children: [
                      const AuthTextField(hint: serviceLocator<LocalizationClass>().appLocalizations!.firstName,
                       label: 
                       serviceLocator<LocalizationClass>().appLocalizations!.username,
                       ).expand(),
                      SizedBox(width: context.width * .05),
                      const AuthTextField(hint: serviceLocator<LocalizationClass>().appLocalizations!.lastName,
                       label: serviceLocator<LocalizationClass>().appLocalizations!.lastName,
                       ).expand(),
                    ],
                  ),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.email,
                    hint: 'you@example.com',
                    controller: _emailController,
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      }
                      return                   serviceLocator<LocalizationClass>().appLocalizations!.enterValidEmail;;
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
                      }
                      return serviceLocator<LocalizationClass>().appLocalizations!.enterValidPassword;
                    },
                  ),
                  AuthTextField(
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
                      child: Text(serviceLocator<LocalizationClass>().appLocalizations!.orLogin),
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
                          text: serviceLocator<LocalizationClass>().appLocalizations!.termsOfServices,
                          style: AppTextStyles.styleWeight600(color: AppColors.mainColor),
                        ),
                        const TextSpan(text: serviceLocator<LocalizationClass>().appLocalizations!.and),
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
      UiMessages.showToast(serviceLocator<LocalizationClass>().appLocalizations!.error);
    }
  }
}
