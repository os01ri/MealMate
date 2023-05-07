import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/router/app_routes.dart';

import '../widgets/auth_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
        titleText: 'Forgot Password',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter Your E-mail Address And We Will Send You A Link To Reset Your Passowrd')
                .paddingHorizontal(20),
            const AuthTextField(
                padding: EdgeInsets.all(20),
                label: 'E-mail Address',
                hint: 'Enter E-mail Address'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MainButton(
                text: 'Send E-mail',
                color: AppColors.buttonColor,
                width: context.width,
                onPressed: () {
                  context.go(Routes.recipesBrowsePage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
