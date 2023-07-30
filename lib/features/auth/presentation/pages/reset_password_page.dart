import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/validation_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/main_app_bar.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../widgets/auth_text_field.dart';
import 'otp_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state.status == AuthStatus.loading) {
            Toaster.showLoading();
          } else if (state.status == AuthStatus.resend) {
            Helper.setUserToken(state.token!);
            Toaster.closeLoading();
            context.myPushNamed(
              RoutesNames.otp,
              extra: OtpPageParams(
                email: _emailController.text,
                authCubit: context.read<AuthCubit>(),
                isResetPassword: true,
              ),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          return Scaffold(
            appBar: MainAppBar(
              size: context.deviceSize,
              titleText: serviceLocator<LocalizationClass>().appLocalizations!.forgotPassword,
            ),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(serviceLocator<LocalizationClass>().appLocalizations!.enterEmailToResetPassword),
                  const SizedBox(height: 10),
                  AuthTextField(
                    label: serviceLocator<LocalizationClass>().appLocalizations!.email,
                    hint: serviceLocator<LocalizationClass>().appLocalizations!.enterEmail,
                    controller: _emailController,
                    validator: (text) {
                      if (text != null && text.isValidEmail()) {
                        return null;
                      }
                      return serviceLocator<LocalizationClass>().appLocalizations!.enterValidEmail;
                    },
                  ),
                  const SizedBox(height: 10),
                  MainButton(
                    text: serviceLocator<LocalizationClass>().appLocalizations!.sendEmail,
                    color: AppColors.mainColor,
                    width: context.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().sendOtpCode(_emailController.text);
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
