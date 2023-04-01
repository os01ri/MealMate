import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../app_routes.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.homePage, index: 0));

  void updateNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(bottomNavItems: Routes.homePage, index: 0));
        break;
      case 1:
        emit(const NavigationState(bottomNavItems: Routes.settingsNamedPage, index: 2));
        break;
    }
  }
}
