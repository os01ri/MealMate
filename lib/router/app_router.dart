import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/features/main/main_page.dart';
import 'package:mealmate/features/onboarding/presentation/pages/onboarding_page.dart';

import 'app_routes.dart';
import 'cubit/navigation_cubit.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homePage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(),
            child: MainPage(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.homePage,
            pageBuilder: (context, state) => NoTransitionPage(
              child: OnboardingPage(),
            ),
            routes: const [
              // GoRoute(
              //   path: Routes.homeDetailsNamedPage,
              //   builder: (context, state) => const HomeDetailsScreen(),
              // ),
            ],
          ),
        ],
      ),
    ],
  );
}
