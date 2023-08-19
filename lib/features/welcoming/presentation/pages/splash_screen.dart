import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/cubit_status.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';
import '../../../../services/shared_prefrences_service.dart';
import '../../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../../../control_panel/presentation/cubit/control_panel_cubit/control_panel_cubit.dart';
import '../widgets/custom_intro_paint.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkIfNeedUserInfo() async {
    if (await SharedPreferencesService.isAuth() && await SharedPreferencesService.getWillSaveToken()) {
      serviceLocator<ControlPanelCubit>().getUserInfo();
    } else {
      serviceLocator<ControlPanelCubit>().dontGetUserInfo();
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
      child: BlocListener<ControlPanelCubit, ControlPanelState>(
        bloc: serviceLocator<ControlPanelCubit>(),
        listener: (context, state) async {
          if (await SharedPreferencesService.isAuth() && await SharedPreferencesService.getWillSaveToken()) {
            if (state.getUserInfoStatus == CubitStatus.initial) {
              serviceLocator<ControlPanelCubit>().getUserInfo();
            } else if (state.getUserInfoStatus == CubitStatus.loading) {
              //do nothing
            } else if (state.getUserInfoStatus == CubitStatus.success) {
              if (context.mounted) context.myGoNamed(RoutesNames.recipesHome);
            } else if (state.getUserInfoStatus == CubitStatus.failure) {
              if (context.mounted) context.myGoNamed(RoutesNames.login);
            }
          } else {
            await Future.delayed(const Duration(seconds: 2));
            if (await SharedPreferencesService.isFirstTimeOpeningApp()) {
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
