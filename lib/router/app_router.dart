import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/change_password_page.dart';
import '../features/auth/presentation/pages/create_account_loading_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/otp_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/control_panel/presentation/pages/control_panel_page.dart';
import '../features/control_panel/presentation/pages/edit_profile_page.dart';
import '../features/control_panel/presentation/pages/favorite_page.dart';
import '../features/control_panel/presentation/pages/restriction_add_page.dart';
import '../features/control_panel/presentation/pages/restrictions_page.dart';
import '../features/control_panel/presentation/pages/settings_page.dart';
import '../features/grocery/presentation/pages/grocery_screen.dart';
import '../features/main/cubit/navigation_cubit.dart';
import '../features/main/pages/shell_page.dart';
import '../features/notifications/presentation/pages/notification_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/recipe/data/models/recipe_model.dart';
import '../features/recipe/presentation/pages/recipe_create_page.dart';
import '../features/recipe/presentation/pages/recipe_details_page.dart';
import '../features/recipe/presentation/pages/recipe_intro_page.dart';
import '../features/recipe/presentation/pages/recipe_search_page.dart';
import '../features/recipe/presentation/pages/recipe_steps_page.dart';
import '../features/recipe/presentation/pages/recipes_home_page.dart';
import '../features/recipe/presentation/pages/view_all_page.dart';
import '../features/store/presentation/pages/cart_page.dart';
import '../features/store/presentation/pages/ingredient_page.dart';
import '../features/store/presentation/pages/map_pick_location_page.dart';
import '../features/store/presentation/pages/order_placed_screen.dart';
import '../features/store/presentation/pages/store_page.dart';
import '../features/store/presentation/pages/wishlist_page.dart';
import '../features/welcoming/presentation/pages/onboarding_page.dart';
import '../features/welcoming/presentation/pages/splash_screen.dart';
import 'routes_names.dart';
import 'transitions/slide_transition.dart';

class AppRouter {
  const AppRouter._();
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/welcome/splash',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [_onboardingRoutes, _authRoutes, _homeShellRoute],
  );

  static final GoRoute _onboardingRoutes = GoRoute(
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

  static final GoRoute _authRoutes = GoRoute(
    path: '/auth',
    builder: (context, state) => const Scaffold(),
    routes: [
      GoRoute(
        path: RoutesNames.signup,
        name: RoutesNames.signup,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: SignUpPage()),
      ),
      GoRoute(
        path: RoutesNames.login,
        name: RoutesNames.login,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: LoginPage()),
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
        pageBuilder: (context, state) => const NoTransitionPage(child: ChangePasswordPage()),
      ),
      GoRoute(
        path: RoutesNames.otp,
        name: RoutesNames.otp,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: OtpPage(args: state.extra as OtpPageParams),
          );
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
      GoRoute(
        path: '/${RoutesNames.controlPanel}',
        name: RoutesNames.controlPanel,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) => const NoTransitionPage(child: ControlPanelPage()),
        routes: _controlPanelRoutes,
      ),
    ],
  );

  static final List<GoRoute> _recipeRoutes = [
    GoRoute(
      path: RoutesNames.recipesSearch,
      name: RoutesNames.recipesSearch,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RecipeSearchPage(),
      ),
    ),
    GoRoute(
      path: RoutesNames.recipesViewAll,
      name: RoutesNames.recipesViewAll,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage(
        child: RecipeViewAllPage(recipes: state.extra as List<RecipeModel>),
      ),
    ),
    GoRoute(
      path: RoutesNames.recipeIntro,
      name: RoutesNames.recipeIntro,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: RecipeIntroPage(recipe: state.extra as RecipeModel),
      ),
    ),
    GoRoute(
      path: RoutesNames.userProfile,
      name: RoutesNames.userProfile,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return NoTransitionPage(
            child: UserProfilePage(
          userId: state.extra as int,
        ));
      },
    ),
    GoRoute(
      path: RoutesNames.recipeDetails,
      name: RoutesNames.recipeDetails,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: RecipeDetailsPage(id: state.extra as int),
      ),
    ),
    GoRoute(
      path: RoutesNames.recipeSteps,
      name: RoutesNames.recipeSteps,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => slideTransition(
        context: context,
        state: state,
        child: RecipeStepsPage(screenParams: state.extra as StepsScreenParams),
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

  static final List<GoRoute> _storeRoutes = [
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
            id: int.tryParse(state.params['id']!) ?? 0,
          ),
        );
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
    GoRoute(
      path: RoutesNames.cartPage,
      name: RoutesNames.cartPage,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: CartPage());
      },
    ),
    GoRoute(
      path: RoutesNames.pickLocation,
      name: RoutesNames.pickLocation,
      parentNavigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: MapPickLocationPage());
      },
    ),
    GoRoute(
      path: RoutesNames.orderPlacedPage,
      name: RoutesNames.orderPlacedPage,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: OrderPlacedScreen());
      },
    ),
  ];

  static final List<GoRoute> _controlPanelRoutes = [
    GoRoute(
      path: RoutesNames.favorite,
      name: RoutesNames.favorite,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return slideTransition(context: context, state: state, child: const FavoritePage());
      },
    ),
    GoRoute(
      path: RoutesNames.grocery,
      name: RoutesNames.grocery,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return slideTransition(context: context, state: state, child: const GroceryPage());
      },
    ),
    GoRoute(
      path: RoutesNames.settings,
      name: RoutesNames.settings,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return slideTransition(context: context, state: state, child: const SettingsPage());
      },
    ),
    GoRoute(
      path: RoutesNames.editProfile,
      name: RoutesNames.editProfile,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return slideTransition(context: context, state: state, child: const EditProfilePage());
      },
    ),
    GoRoute(
      path: RoutesNames.restrictions,
      name: RoutesNames.restrictions,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return slideTransition(context: context, state: state, child: const RestrictionsPage());
      },
      routes: [
        GoRoute(
          path: RoutesNames.addRestriction,
          name: RoutesNames.addRestriction,
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) {
            return slideTransition(context: context, state: state, child: const AddRestrictionPage());
          },
        ),
      ],
    ),
  ];
}
