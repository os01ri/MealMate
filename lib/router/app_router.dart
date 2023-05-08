import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/features/auth/presentation/pages/create_account_loading.dart';
import 'package:mealmate/features/auth/presentation/pages/forgot_password.dart';
import 'package:mealmate/features/auth/presentation/pages/otp_screen.dart';
import 'package:mealmate/features/auth/presentation/pages/signup_page.dart';
import 'package:mealmate/features/main/main_page.dart';
import 'package:mealmate/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mealmate/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_create_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_intro.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipes_browse_page.dart';
import 'package:mealmate/router/cubit/navigation_cubit.dart';
import 'package:mealmate/router/transitions/slide_transition.dart';

import '../features/auth/presentation/pages/login_page.dart';
import 'app_routes.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.splashPage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.splashPage,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.onboardingPage,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: OnboardingPage(),
        ),
      ),
      GoRoute(
        path: Routes.forgotPasswordPage,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: ForgotPasswordPage());
        },
      ),
      GoRoute(
          path: Routes.otpScreen,
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ConfirmPhoneNumberScreen())),
      GoRoute(
        path: Routes.signUpNamedPage,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(child: SignUpPage()),
      ),
      GoRoute(
        path: Routes.loginNamedPage,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
      ),  
      GoRoute(
        path: Routes.accountCreationLoading,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return slideTransition(
              context: context, state: state, child: CreateAccountLoading());
        },
      ),   
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
            path: Routes.recipesBrowsePage,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RecipesBrowsePage(),
            ),
          ),
          GoRoute(
            path: Routes.recipeIntro,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => slideTransition(
              context: context,
              state: state,
              child: const RecipeIntro(),
            ),
          ),
          GoRoute(
            path: Routes.recipePage,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => slideTransition(
              context: context,
              state: state,
              child: const RecipePage(),
            ),
          ),
          GoRoute(
            path: Routes.recipeCreatePage,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => slideTransition(
              context: context,
              state: state,
              child: const RecipeCreatePage(),
            ),
          ),
        ],
      ),
    ],
  );
}
