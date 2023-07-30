import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/validation_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/toaster.dart';
import '../../../../core/ui/widgets/main_app_bar.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../widgets/auth_text_field.dart';

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
      Toaster.showLoading();
    }
    if (state.status == AuthStatus.failed) {
      Toaster.closeLoading();
    }
    if (state.status == AuthStatus.success) {
      Toaster.closeLoading();
      context.myGoNamed(
        RoutesNames.login,
      );
    }
  }
}
