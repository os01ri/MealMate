import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mealmate/router/app_routes.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: AppRoutes.home, index: 0));

  void updateNavBarItem(int index) {
    log(index.toString(), name: 'nav index');

    emit(NavigationState(
      index: index,
      bottomNavItems: switch (index) {
        0 => AppRoutes.home,
        1 => AppRoutes.storePage,
        2 => AppRoutes.notification,
        _ => AppRoutes.home,
      },
    ));
  }
}
