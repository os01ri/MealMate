import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/router/app_routes.dart';
import 'package:mealmate/router/cubit/navigation_cubit.dart';

class MainPage extends StatelessWidget {
  final Widget screen;

  MainPage({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.mainColor,
                AppColors.lightOrange,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
            ),
          ),
          child: FloatingActionButton(
            elevation: .0,
            highlightElevation: .0,
            foregroundColor: Colors.white,
            splashColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              context.push(Routes.recipeCreatePage);
            },
          ),
        ),
      ),
    );
  }

  final _tabs = [
    const MainNavigationBarItemWidget(
      initialLocation: Routes.recipesBrowsePage,
      icon: Icon(Icons.home_rounded),
      label: 'Home',
      index: 0,
    ),
    const MainNavigationBarItemWidget(
      initialLocation: Routes.store,
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'store',
      padding: EdgeInsets.only(right: 40),
      index: 1,
    ),
    const MainNavigationBarItemWidget(
      initialLocation: Routes.notificationScreen,
      icon: Icon(Icons.notifications),
      label: 'Notification',
      padding: EdgeInsets.only(left: 40),
      index: 2,
    ),
    const MainNavigationBarItemWidget(
      initialLocation: Routes.recipesBrowsePage,
      icon: Icon(Icons.settings),
      label: 'Setting',
      index: 3,
    ),
  ];

  BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(ctx) =>
      BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn,
            height: 70.0,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomAppBar(
                shadowColor: Colors.black,
                elevation: 50,
                color: Colors.white,
                notchMargin: 10.0,
                shape: const CircularNotchedRectangle(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _tabs
                        .map(
                          (e) => Padding(
                            padding: e.padding,
                            child: IconButton(
                              icon: e.icon,
                              color: AppColors.mainColor,
                              onPressed: () {
                                if (state.index != e.index) {
                                  context.read<NavigationCubit>().updateNavBarItem(e.index);
                                  context.go(_tabs[e.index].initialLocation);
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class MainNavigationBarItemWidget {
  final String initialLocation;
  final Widget icon;
  final String? label;
  final int index;
  final EdgeInsetsGeometry padding;

  const MainNavigationBarItemWidget({
    required this.initialLocation,
    required this.icon,
    required this.index,
    this.padding = EdgeInsets.zero,
    this.label,
  });
}
