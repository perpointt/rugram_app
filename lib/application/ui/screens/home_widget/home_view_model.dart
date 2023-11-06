import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';

class HomeViewModel {
  final items = [
    AppNavigationItem(
      icon: Icons.home,
      route: const WelcomeRoute(),
      path: AppRouteNames.welcome,
    ),
    AppNavigationItem(
      icon: Icons.add_box_outlined,
      path: AppRouteNames.select,
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

  Future<void> navigate(BuildContext context, int index) async {
    if (index == 1) {
      AppNavigator.navigateTo(context, const SelectPhotoRoute());
    } else {
      final route = items[index].route;
      if (route == null) return;
      AppNavigator.navigateTo(context, route);
    }
  }

  int getActiveIndex(int index) {
    if (index > 0) return index + 1;
    return index;
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
