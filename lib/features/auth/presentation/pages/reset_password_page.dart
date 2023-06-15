import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/helper.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/routes_names.dart';

import '../../../../core/localization/localization_class.dart';
import '../../../../dependency_injection.dart';
import 'otp_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _authCubit = AuthCubit();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => _authCubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: _authCubit,
        listener: (context, state) {
          if (state.status == AuthStatus.loading) {
            BotToast.showLoading();
          }
          if (state.status == AuthStatus.resend) {
            Helper.setUserToken(state.token!);
            BotToast.closeAllLoading();
            context.pushNamed(RoutesNames.otp,
                extra: OtpPageParams(
                    authCubit: _authCubit, isResetPassword: true));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(
              size: context.deviceSize,
              titleText: serviceLocator<LocalizationClass>()
                  .appLocalizations!
                  .forgotPassword,
            ),
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(serviceLocator<LocalizationClass>()
                      .appLocalizations!
                      .enterEmailToResetPassword),
                  const SizedBox(height: 10),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .email,
                    hint: serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .enterEmail,
                    controller: emailController,
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      }
                      return serviceLocator<LocalizationClass>()
                          .appLocalizations!
                          .enterValidEmail;
                    },
                  ),
                  const SizedBox(height: 10),
                  MainButton(
                    text: serviceLocator<LocalizationClass>()
                        .appLocalizations!
                        .sendEmail,
                    color: AppColors.mainColor,
                    width: context.width,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _authCubit.sendOtpCode(emailController.text);
                      }
                    },
                  ),
                ],
              ).padding(AppConfig.pagePadding),
            ),
          );
        },
      ),
    );
  }
}
