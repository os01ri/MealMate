import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/router/routes_names.dart';

import '../../../../core/cubit/language_cubit.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/flutter_switch.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../core/ui/widgets/restart_widget.dart';
import '../../../../dependency_injection.dart';
import '../../../../services/shared_prefrences_service.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: RecipeAppBar(
          context: context,
          title: serviceLocator<LocalizationClass>().appLocalizations!.settings,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SettingsItem(),
            Text(
              serviceLocator<LocalizationClass>().appLocalizations!.logOut,
              style: const TextStyle(color: Colors.red).largeFontSize.semiBold,
            ).onTap(() => showLogOutDialog(context)),
          ],
        ).paddingAll(20),
      ),
    );
  }

  showLogOutDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadius),
          child: Container(
            decoration: BoxDecoration(borderRadius: AppConfig.borderRadius),
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
                  style: const TextStyle().semiBold.largeFontSize,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    MainButton(
                      text: 'نعم',
                      color: AppColors.mainColor,
                      onPressed: () {
                        SharedPreferencesService.deleteToken();
                        context.myGoNamed(RoutesNames.splash);
                      },
                    ).expand(),
                    const SizedBox(width: 10),
                    MainButton(
                      text: 'لا',
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: () => context.myPop(),
                    ).expand(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              serviceLocator<LocalizationClass>().appLocalizations!.languageValue,
              style: const TextStyle().largeFontSize.semiBold,
            ),
            const Spacer(),
            FlutterSwitch(
              value: serviceLocator<LanguageCubit>().state.locale == supportedLocales[0],
              activeColor: AppColors.mainColor,
              inactiveColor: AppColors.mainColor,
              onToggle: (value) {
                value
                    ? serviceLocator<LanguageCubit>().changeLanguage(supportedLocales[0])
                    : serviceLocator<LanguageCubit>().changeLanguage(supportedLocales[1]);
                RestartWidget.restartApp(context);
              },
            )
          ],
        ),
        Divider(color: Colors.grey[700]).paddingVertical(10),
      ],
    );
  }
}
