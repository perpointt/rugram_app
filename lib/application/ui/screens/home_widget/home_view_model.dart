import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';

class HomeViewModel {
  final controller = AdvancedDrawerController();

  final items = [
    AppNavigationItem(
      icon: Icons.home,
      route: const WelcomeRoute(),
      path: AppRouteNames.welcome,
    ),
    AppNavigationItem(
      icon: Icons.camera,
      path: AppRouteNames.camera,
    ),
    AppNavigationItem(
      icon: Icons.person,
      route: const ProfileRoute(),
      path: AppRouteNames.profile,
    ),
  ];

  List<PageRouteInfo<void>> get routes {
    final values = items.map((e) => e.route).toList();
    values.removeWhere((value) => value == null);
    return List<PageRouteInfo<void>>.from(values);
  }

  void navigate(BuildContext context, int index) {
    if (index == 1) {
      controller.showDrawer();
    } else {
      final route = items[index].route;
      if (route == null) return;
      AppNavigator.navigateTo(context, route);
    }
  }

  int get activeIndex {
    final paths = items.map((e) => e.path).toList();

    return paths.indexWhere((element) {
      return AppNavigator.uri.pathSegments.contains(element);
    });
  }
}

class AppNavigationItem {
  final String path;
  final IconData icon;
  final PageRouteInfo<void>? route;

  AppNavigationItem({
    required this.path,
    required this.icon,
    this.route,
  });
}
