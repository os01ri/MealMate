import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../app_routes.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.homePage, index: 0));

  void updateNavBarItem(int index) {
    emit(NavigationState(bottomNavItems: Routes.homePage, index: index));
    // switch (index) {
    // emit(NavigationState(bottomNavItems: Routes.homePage, index: index));
    //   case 0:
    //   break;
    // case 1:
    //   emit(const NavigationState(bottomNavItems: Routes.settingsNamedPage, index: 2));
    //   break;

    // }
  }
}
