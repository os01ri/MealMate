import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/helper/app_config.dart';

CustomTransitionPage slideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppConfig.navigationAnimationDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      position: Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}
