import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(size: context.deviceSize, titleText: 'Create an Account'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AuthTextField(label: 'User Name', hint: 'username'),
          Row(
            children: [
              const Expanded(
                child: AuthTextField(hint: 'first name', label: 'First Name'),
              ),
              SizedBox(width: context.width * .05),
              const Expanded(
                child: AuthTextField(hint: 'last name', label: 'Last Name'),
              ),
            ],
          ),
          const AuthTextField(hint: 'you@example.com', label: 'E-mail'),
          const AuthTextField(label: 'Password', hint: '********'),
          const AuthTextField(label: 'Confirm Password', hint: '********'),
          const SizedBox(height: 20),
          MainButton(
            text: 'Sign Up',
            color: AppColors.mainColor,
            width: context.width,
            onPressed: () {
              context.go(Routes.otpScreen);
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
                TextSpan(text: 'Terms of Services', style: AppTextStyles.styleWeight600(color: AppColors.mainColor)),
                const TextSpan(text: ' & '),
                TextSpan(text: 'Privacy Policy', style: AppTextStyles.styleWeight600(color: AppColors.mainColor))
              ],
            ),
          ),
        ],
      ).padding(AppConfig.pagePadding).scrollable(),
    );
  }
}
