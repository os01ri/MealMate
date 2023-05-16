import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/router/app_routes.dart';

import '../widgets/auth_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(size: size, titleText: 'Create an Account'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AuthTextField(label: 'User Name', hint: 'username'),
            const Row(
              children: [
                Expanded(
                  child: AuthTextField(hint: 'first name', label: 'First Name'),
                ),
                Expanded(
                  child: AuthTextField(hint: 'last name', label: 'Last Name'),
                ),
              ],
            ),
            const AuthTextField(hint: 'you@example.com', label: 'E-mail'),
            const AuthTextField(label: 'Password', hint: '********'),
            const AuthTextField(label: 'Confirm Password', hint: '********'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainButton(
                text: 'Sign Up',
                color: AppColors.buttonColor,
                width: context.width,
                onPressed: () {
                  context.push(Routes.otpScreen);
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                  child: const Text('or Login'),
                  onPressed: () {
                    context.push(Routes.loginNamedPage);
                  }),
            ),
            RichText(
              text: TextSpan(
                text: 'By continuing you agree to the\n',
                style: AppTextStyles.styleWeight400(color: Colors.grey),
                children: [
                  TextSpan(
                      text: 'Terms of Services', style: AppTextStyles.styleWeight600(color: AppColors.buttonColor)),
                  const TextSpan(text: ' & '),
                  TextSpan(text: 'Privacy Policy', style: AppTextStyles.styleWeight600(color: AppColors.buttonColor))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

