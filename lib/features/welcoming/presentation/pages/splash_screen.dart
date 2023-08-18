import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/font/typography.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../cubit/user_cubit.dart';
import '../widgets/custom_intro_paint.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkIfNeedUserInfo() async {
    if (await Helper.isAuth() && await Helper.getWillSaveToken()) {
      serviceLocator<UserCubit>().getUserInfo();
    } else {
      serviceLocator<UserCubit>().dontGetUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIfNeedUserInfo();
    return BlocListener<AuthCubit, AuthState>(
      bloc: serviceLocator<AuthCubit>(),
      listener: (context, state) {
        if (state.status == AuthStatus.unAuthenticated) {
          context.myGo(RoutesNames.login);
        }
      },
      child: BlocListener<UserCubit, UserState>(
        bloc: serviceLocator<UserCubit>(),
        listener: (context, state) async {
          if (await Helper.isAuth() && await Helper.getWillSaveToken()) {
            if (state.userInfoStatus == CubitStatus.initial) {
              serviceLocator<UserCubit>().getUserInfo();
            } else if (state.userInfoStatus == CubitStatus.loading) {
              //do nothing
            } else if (state.userInfoStatus == CubitStatus.success) {
              if (context.mounted) context.myGoNamed(RoutesNames.recipesHome);
            } else if (state.userInfoStatus == CubitStatus.failure) {
              if (context.mounted) context.myGoNamed(RoutesNames.login);
            }
          } else {
            if (await Helper.isFirstTimeOpeningApp()) {
              if (context.mounted) context.myGoNamed(RoutesNames.onboarding);
            } else {
              if (context.mounted) context.myGoNamed(RoutesNames.login);
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.orange,
          body: SafeArea(
            child: CustomPaint(
              painter: const RPSCustomPainter(),
              size: context.deviceSize,
              child: SizedBox(
                height: 150,
                child: Text(
                  'Meal Mate',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                    fontSize: 50,
                  ).extraBold,
                ),
              ).center(),
            ),
          ),
        ),
      ),
    );
  }
}
