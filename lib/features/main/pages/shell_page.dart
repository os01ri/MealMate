import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/routing_extensions.dart';
import '../../../core/extensions/widget_extensions.dart';
import '../../../core/ui/theme/colors.dart';
import '../cubit/navigation_cubit.dart';
import '../../../router/routes_names.dart';

part '../widgets/main_fab.dart';

class ShellPage extends StatelessWidget {
  final Widget screen;

  const ShellPage({Key? key, required this.screen}) : super(key: key);
 
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      drawer: const Drawer(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _CreateRecipeFAB(),
    );
  }

  _buildBottomNavigationBar() {
    return BlocBuilder<NavigationCubit, NavigationState>(
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
                                context.goNamed(_tabs[e.index].routePath);
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

  static const _tabs = [
    _MainNavigationBarItemWidget(
      routePath: RoutesNames.recipesHome,
      icon: Icon(Icons.home_rounded),
      label: 'Home',
      index: 0,
    ),
    _MainNavigationBarItemWidget(
      routePath: RoutesNames.storePage,
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'Store',
      padding: EdgeInsetsDirectional.only(end: 40),
      index: 1,
    ),
    _MainNavigationBarItemWidget(
      routePath: RoutesNames.notification,
      icon: Icon(Icons.notifications),
      label: 'Notification',
      padding: EdgeInsetsDirectional.only(start: 40),
      index: 2,
    ),
    _MainNavigationBarItemWidget(
      routePath: RoutesNames.recipesHome,
      icon: Icon(Icons.person),
      label: 'Profile',
      index: 3,
    ),
  ];
}

class _MainNavigationBarItemWidget {
  final String routePath;
  final Widget icon;
  final String? label;
  final int index;
  final EdgeInsetsGeometry padding;

  const _MainNavigationBarItemWidget({
    required this.routePath,
    required this.icon,
    required this.index,
    this.padding = EdgeInsets.zero,
    this.label,
  });
}
