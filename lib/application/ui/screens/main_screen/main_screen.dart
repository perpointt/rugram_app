import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoTabsRouter.pageView(
      routes: [
        CameraRoute(),
        HomeRoute(),
      ],
    );
  }
}
