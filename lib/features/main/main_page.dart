import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';

import '../../core/ui/widgets/main_nav_bar_item_widget.dart';
import '../../router/app_routes.dart';
import '../../router/cubit/navigation_cubit.dart';

class MainPage extends StatelessWidget {
  final Widget screen;

  MainPage({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, _tabs),
    );
  }

  final _tabs = [
    MainNavigationBarItemWidget(
      initialLocation: Routes.homePage,
      icon: const Icon(Icons.home),
      label: 'Home',
    ),
    MainNavigationBarItemWidget(
      initialLocation: Routes.settingsNamedPage,
      icon: const Icon(Icons.settings),
      label: 'Setting',
    ),
  ];

  BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(
    ctx,
    List<MainNavigationBarItemWidget> tabs,
  ) =>
      BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (value) {
              if (state.index != value) {
                context.read<NavigationCubit>().updateNavBarItem(value);
                context.go(tabs[value].initialLocation);
              }
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(size: (IconTheme.of(ctx).size)! * 1.3),
            items: tabs,
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
          );
        },
      );
}
