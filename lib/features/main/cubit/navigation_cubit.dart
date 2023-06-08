import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(index: 0));

  void updateNavBarItem(int index) {
    log(index.toString(), name: 'nav index');
    emit(NavigationState(index: index));
  }
}
