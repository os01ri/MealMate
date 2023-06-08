import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/routes_names.dart';

import '../../../../core/localization/localization_class.dart';
import '../../../../injection_container.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        size: context.deviceSize,
        titleText: serviceLocator<LocalizationClass>()
            .appLocalizations!
            .forgotPassword,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(serviceLocator<LocalizationClass>()
              .appLocalizations!
              .enterEmailToResetPassword),
          const SizedBox(height: 10),
          AuthTextField(
            label: serviceLocator<LocalizationClass>().appLocalizations!.email,
            hint: serviceLocator<LocalizationClass>()
                .appLocalizations!
                .enterEmail,
          ),
          const SizedBox(height: 10),
          MainButton(
            text:
                serviceLocator<LocalizationClass>().appLocalizations!.sendEmail,
            color: AppColors.mainColor,
            width: context.width,
            onPressed: () {
              context.goNamed(RoutesNames.recipesHome);
            },
          ),
        ],
      ).padding(AppConfig.pagePadding),
    );
  }
}
