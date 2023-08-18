import 'package:flutter/material.dart';
import 'package:mealmate/core/cubit/language_cubit.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/flutter_switch.dart';
import 'package:mealmate/core/ui/widgets/restart_widget.dart';
import 'package:mealmate/dependency_injection.dart';

import '../../../../core/localization/localization_class.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(serviceLocator<LocalizationClass>()
                  .appLocalizations!
                  .languageValue),
              const Spacer(),
              FlutterSwitch(
                  value: serviceLocator<LanguageCubit>().state.locale ==
                      supportedLocales[0],
                  activeColor: AppColors.mainColor,
                  inactiveColor: AppColors.mainColor,
                  onToggle: (value) {
                    value
                        ? serviceLocator<LanguageCubit>()
                            .changeLanguage(supportedLocales[0])
                        : serviceLocator<LanguageCubit>()
                            .changeLanguage(supportedLocales[1]);
                    RestartWidget.restartApp(context);
                  })
            ],
          )
        ],
      ),
    );
  }
}
