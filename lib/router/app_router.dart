import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mealmate/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_page.dart';

import 'app_routes.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.recipePage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.splashPage,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.onboardingPage,
        pageBuilder: (context, state) => NoTransitionPage(
          child: OnboardingPage(),
        ),
      ),
      GoRoute(
        path: Routes.recipePage,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: RecipePage(),
        ),
      ),
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return BlocProvider<NavigationCubit>(
      //       create: (context) => NavigationCubit(),
      //       child: MainPage(screen: child),
      //     );
      //   },
      //   routes: const [],
      // ),
    ],
  );
}
