import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        titleText: 'Login',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AuthTextField(
            label: 'E-mail Address',
            hint: 'Enter E-mail Address',
          ),
          AuthTextField(label: 'Password', hint: '********'),
          const SizedBox(height: 20),
          MainButton(
            text: 'Login',
            color: AppColors.mainColor,
            width: context.width,
            onPressed: () => context.push(Routes.accountCreationLoading),
          ),
          TextButton(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColors.mainColor)),
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
      ).padding(AppConfig.pagePadding).scrollable(),
    );
  }
}
