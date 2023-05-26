import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/features/auth/presentation/pages/create_account_loading_page.dart';
import 'package:mealmate/features/auth/presentation/pages/login_page.dart';
import 'package:mealmate/features/auth/presentation/pages/otp_page.dart';
import 'package:mealmate/features/auth/presentation/pages/reset_password_page.dart';
import 'package:mealmate/features/auth/presentation/pages/signup_page.dart';
import 'package:mealmate/features/main/cubit/navigation_cubit.dart';
import 'package:mealmate/features/main/main_page.dart';
import 'package:mealmate/features/notification/notification_page.dart';
import 'package:mealmate/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mealmate/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_create_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_details_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_intro_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_steps_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipes_home_page.dart';
import 'package:mealmate/features/store/presentation/pages/ingredient_page.dart';
import 'package:mealmate/features/store/presentation/pages/store_page.dart';
import 'package:mealmate/features/store/presentation/pages/wishlist_page.dart';
import 'package:mealmate/router/transitions/slide_transition.dart';

import 'app_routes.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      _shellRoute,
      ..._splashRoutes,
      ..._authRoutes,
      ..._recipeRoutes,
      ..._ingredientRoutes,
    ],
  );

  static final ShellRoute _shellRoute = ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MainPage(screen: child),
    ),
    routes: [
      GoRoute(
        path: AppRoutes.notification,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: NotificationPage()),
      ),
      GoRoute(
        path: AppRoutes.recipesHome,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: RecipesHomePage()),
      ),
      GoRoute(
        path: AppRoutes.storePage,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: StorePage()),
      ),
      GoRoute(
        path: AppRoutes.wishListPage,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          final arg = (state.extra as void Function(GlobalKey));
          return NoTransitionPage(
              child: WishlistPage(
            onAddToCart: arg,
          ));
        },
      ),
    ],
  );

  static final _splashRoutes = [
    GoRoute(
      path: AppRoutes.splash,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => const NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage(child: OnboardingPage()),
    ),
  ];

  static final _authRoutes = [
    GoRoute(
      path: AppRoutes.forgotPassword,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => const NoTransitionPage(child: ResetPasswordPage()),
    ),
    GoRoute(
        path: AppRoutes.otp,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: OtpPage())),
    GoRoute(
      path: AppRoutes.signup,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage(child: SignUpPage()),
    ),
    GoRoute(
      path: AppRoutes.login,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
    ),
    GoRoute(
      path: AppRoutes.accountCreationLoading,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const CreateAccountLoadingPage(),
      ),
    ),
  ];

  static final _recipeRoutes = [
    GoRoute(
      path: AppRoutes.recipeIntro,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeIntroPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.recipeCreate,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeCreatePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.recipeDetails,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeDetailsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.recipeSteps,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeStepsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.recipeDetails,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeDetailsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.recipeSteps,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeStepsPage(),
      ),
    ),
  ];

  static final _ingredientRoutes = [
    GoRoute(
      path: AppRoutes.ingredient,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final record = state.extra as (void Function(GlobalKey), void Function(GlobalKey));
        return slideTransition(
          context: context,
          state: state,
          child: IngredientPage(
            onAddToCart: record.$1,
            onAddToWishlist: record.$2,
          ),
        );
      },
    ),
  ];
}
