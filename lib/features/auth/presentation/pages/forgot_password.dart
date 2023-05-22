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

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        titleText: 'Forgot Password',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Enter Your E-mail Address And We Will Send You A Link To Reset Your Passowrd'),
          const SizedBox(height: 10),
          const AuthTextField(label: 'E-mail Address', hint: 'Enter E-mail Address'),
          const SizedBox(height: 10),
          MainButton(
            text: 'Send E-mail',
            color: AppColors.mainColor,
            width: context.width,
            onPressed: () {
              context.go(Routes.recipesBrowsePage);
            },
          ),
        ],
      ).padding(AppConfig.pagePadding),
    );
  }
}
