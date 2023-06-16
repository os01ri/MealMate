import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/features/main/cubit/navigation_cubit.dart';

import '../../router/routes_names.dart';

class MainPage extends StatelessWidget {
  final Widget screen;

  const MainPage({Key? key, required this.screen}) : super(key: key);

  static const _tabs = [
    MainNavigationBarItemWidget(
      initialLocation: RoutesNames.recipesHome,
      icon: Icon(Icons.home_rounded),
      label: 'Home',
      index: 0,
    ),
    MainNavigationBarItemWidget(
      initialLocation: RoutesNames.storePage,
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'store',
      padding: EdgeInsets.only(right: 40),
      index: 1,
    ),
    MainNavigationBarItemWidget(
      initialLocation: RoutesNames.notification,
      icon: Icon(Icons.notifications),
      label: 'Notification',
      padding: EdgeInsets.only(left: 40),
      index: 2,
    ),
    MainNavigationBarItemWidget(
      initialLocation: RoutesNames.storePage,
      icon: Icon(Icons.person),
      label: 'Profile',
      index: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
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
          splashColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ).paddingAll(12.0),
          onPressed: () {
            context.push(RoutesNames.recipeCreate);
          },
        ),
      ),
    );
  }

  BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(ctx) =>
      BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return Container(
            height: 60.0,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomAppBar(
                // shadowColor: Colors.black,
                // elevation: 50,
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
                              color: state.index == e.index ? AppColors.mainColor : AppColors.grey2,
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
