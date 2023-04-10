import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/main/main_page.dart';
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MyHomePage(title: 'Flutter Demo Home Page'),
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
