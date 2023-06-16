import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/validation_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/localization/localization_class.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_app_bar.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mealmate/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mealmate/router/routes_names.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _listener,
          builder: (BuildContext context, AuthState state) {
            return Scaffold(
              appBar: MainAppBar(
                size: context.deviceSize,
                leadingWidget: const SizedBox.shrink(),
                titleText: serviceLocator<LocalizationClass>().appLocalizations!.forgotPassword,
              ),
              body: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(serviceLocator<LocalizationClass>().appLocalizations!.enterNewPassword),
                    const SizedBox(height: 10),
                    AuthTextField(
                      label: serviceLocator<LocalizationClass>().appLocalizations!.password,
                      hint: '********',
                      isPassword: true,
                      controller: _passwordController,
                      validator: (text) {
                        if (text != null && text.isValidPassword()) {
                          return null;
                        }
                        return serviceLocator<LocalizationClass>().appLocalizations!.enterValidPassword;
                      },
                    ),
                    AuthTextField(
                      label: serviceLocator<LocalizationClass>().appLocalizations!.confirmPassword,
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (text) {
                        if (text != null && text == _passwordController.text) {
                          return null;
                        } else {
                          return serviceLocator<LocalizationClass>().appLocalizations!.passwordNotMatch;
                        }
                      },
                      hint: '********',
                    ),
                    const SizedBox(height: 10),
                    MainButton(
                      text: serviceLocator<LocalizationClass>().appLocalizations!.next,
                      color: AppColors.mainColor,
                      width: context.width,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().changePassword(_passwordController.text);
                        }
                      },
                    ),
                  ],
                ).padding(AppConfig.pagePadding),
              ),
            );
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, AuthState state) {
    if (state.status == AuthStatus.loading) {
      BotToast.showLoading();
    }
    if (state.status == AuthStatus.failed) {
      BotToast.closeAllLoading();
    }
    if (state.status == AuthStatus.success) {
      BotToast.closeAllLoading();
      context.goNamed(
        RoutesNames.login,
      );
    }
  }
}
