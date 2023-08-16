import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    serviceLocator<UserCubit>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: serviceLocator<AuthCubit>(),
      listener: (context, state) {
        if (state.status == AuthStatus.unAthenticated) {
          context.myGo(RoutesNames.login);
        }
      },
      child: BlocListener<UserCubit, UserState>(
        bloc: serviceLocator<UserCubit>(),
        listener: (context, state) async {
          if (state.userInfoStatus == CubitStatus.initial) {
            serviceLocator<UserCubit>().getUserInfo();
          } else if (state.userInfoStatus == CubitStatus.loading) {
            //do nothing
          } else if (state.userInfoStatus == CubitStatus.success) {
            if (await Helper.getWillSaveToken()) {
              if (context.mounted) context.myGo(RoutesNames.recipesHome);
            } else {
              if (context.mounted) context.myGo(RoutesNames.login);
            }
          } else if (state.userInfoStatus == CubitStatus.failure) {
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
            ),
          ),
        ),
      ),
    );
  }
}
