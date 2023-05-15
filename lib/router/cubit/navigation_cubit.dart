import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../app_routes.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.homePage, index: 0));

  void updateNavBarItem(int index) {
    log(index.toString(), name: 'nav index');
    emit(NavigationState(
      index: index,
      bottomNavItems: switch (index) {
        0 => Routes.homePage,
        1 => Routes.store,
        _ => Routes.homePage,
      },
    ));
  }
}
