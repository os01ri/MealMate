import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

import '../widgets/auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: size,
        titleText: 'Login',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AuthTextField(
                label: 'E-mail Address', hint: 'Enter E-mail Address'),
            const AuthTextField(label: 'Password', hint: '********'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainButton(
                text: 'Login',
                color: AppColors.buttonColor,
                width: context.width,
                onPressed: () {
                  context.go(Routes.recipesBrowsePage);
                },
              ),
            ),
            TextButton(
              child: Text('Forgot Passowrd?'),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(AppColors.buttonColor)),
              onPressed: () {
                context.push(Routes.forgotPasswordPage);
              },
            ),
            SizedBox(
              height: context.height * .25,
            ),
            Column(
              children: [
                Text('or continue with'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    text: 'Login With Google',
                    color: AppColors.buttonColor,
                    width: context.width,
                    onPressed: () {
                      context.go(Routes.recipesBrowsePage);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    text: 'Login With Facebook',
                    color: Colors.blue,
                    width: context.width,
                    onPressed: () {
                      context.go(Routes.recipesBrowsePage);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
