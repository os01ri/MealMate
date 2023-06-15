import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mealmate/features/auth/presentation/pages/change_password_page.dart';
import 'package:mealmate/features/auth/presentation/pages/create_account_loading_page.dart';
import 'package:mealmate/features/auth/presentation/pages/login_page.dart';
import 'package:mealmate/features/auth/presentation/pages/otp_page.dart';
import 'package:mealmate/features/auth/presentation/pages/reset_password_page.dart';
import 'package:mealmate/features/auth/presentation/pages/signup_page.dart';
import 'package:mealmate/features/main/cubit/navigation_cubit.dart';
import 'package:mealmate/features/main/pages/shell_page.dart';
import 'package:mealmate/features/notification/notification_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_create_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_details_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_intro_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipe_steps_page.dart';
import 'package:mealmate/features/recipe/presentation/pages/recipes_home_page.dart';
import 'package:mealmate/features/store/presentation/pages/cart_page.dart';
import 'package:mealmate/features/store/presentation/pages/ingredient_page.dart';
import 'package:mealmate/features/store/presentation/pages/store_page.dart';
import 'package:mealmate/features/store/presentation/pages/wishlist_page.dart';
import 'package:mealmate/features/welcoming/presentation/pages/onboarding_page.dart';
import 'package:mealmate/features/welcoming/presentation/pages/splash_screen.dart';
import 'package:mealmate/router/transitions/slide_transition.dart';

import 'routes_names.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/welcome/splash',
    // redirect: (context, state) => '/${RoutesNames.recipesHome}',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      _welcomingRoutes,
      _authRoutes,
      _homeShellRoute,
    ],
  );

  static final ShellRoute _homeShellRoute = ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: ShellPage(screen: child),
    ),
    routes: [
      GoRoute(
        path: '/${RoutesNames.recipesHome}',
        name: RoutesNames.recipesHome,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: RecipesHomePage()),
        routes: _recipeRoutes,
      ),
      GoRoute(
        path: '/${RoutesNames.storePage}',
        name: RoutesNames.storePage,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: StorePage()),
        routes: _storeRoutes,
      ),
      GoRoute(
        path: '/${RoutesNames.notification}',
        name: RoutesNames.notification,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: NotificationPage()),
      ),
    ],
  );

  static final _welcomingRoutes = GoRoute(
    path: '/welcome',
    builder: (context, state) => const Scaffold(),
    routes: [
      GoRoute(
        path: RoutesNames.splash,
        name: RoutesNames.splash,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: SplashScreen()),
      ),
      GoRoute(
        path: RoutesNames.onboarding,
        name: RoutesNames.onboarding,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(child: OnboardingPage()),
      ),
    ],
  );

  static final _authRoutes = GoRoute(
    path: '/auth',
    builder: (context, state) => const Scaffold(),
    routes: [
      GoRoute(
        path: RoutesNames.signup,
        name: RoutesNames.signup,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(child: SignUpPage()),
      ),
      GoRoute(
        path: RoutesNames.login,
        name: RoutesNames.login,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: RoutesNames.forgotPassword,
        name: RoutesNames.forgotPassword,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: ResetPasswordPage()),
      ),
      GoRoute(
        path: RoutesNames.changePassword,
        name: RoutesNames.changePassword,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ChangePasswordPage()),
      ),
      GoRoute(
        path: RoutesNames.otp,
        name: RoutesNames.otp,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
              child: OtpPage(
            args: state.extra as OtpPageParams,
          ));
        },
      ),
      GoRoute(
        path: RoutesNames.accountCreationLoading,
        name: RoutesNames.accountCreationLoading,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => slideTransition(
          context: context,
          state: state,
          child: const CreateAccountLoadingPage(),
        ),
      ),
    ],
  );

  static final _recipeRoutes = [
    GoRoute(
      path: RoutesNames.recipeIntro,
      name: RoutesNames.recipeIntro,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeIntroPage(),
      ),
    ),
    GoRoute(
      path: RoutesNames.recipeDetails,
      name: RoutesNames.recipeDetails,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeDetailsPage(),
      ),
    ),
    GoRoute(
      path: RoutesNames.recipeSteps,
      name: RoutesNames.recipeSteps,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeStepsPage(),
      ),
    ),
    GoRoute(
      path: RoutesNames.recipeCreate,
      name: RoutesNames.recipeCreate,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: const RecipeCreatePage(),
      ),
    ),
  ];

  static final _storeRoutes = [
    GoRoute(
      path: '${RoutesNames.ingredient}/:id',
      name: RoutesNames.ingredient,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final record = state.extra as (void Function(GlobalKey), void Function(GlobalKey));
        return slideTransition(
          context: context,
          state: state,
          child: IngredientPage(
            onAddToCart: record.$1,
            onAddToWishlist: record.$2,
            id: state.params['id']!,
          ),
        );
      },
    ),
    GoRoute(
      path: RoutesNames.cartPage,
      name: RoutesNames.cartPage,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: CartPage());
      },
    ),
    GoRoute(
      path: RoutesNames.wishListPage,
      name: RoutesNames.wishListPage,
      parentNavigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state) {
        final arg = (state.extra as void Function(GlobalKey));
        return NoTransitionPage(child: WishlistPage(onAddToCart: arg));
      },
    ),
  ];
}
