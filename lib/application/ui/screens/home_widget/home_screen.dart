import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/home_widget/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final routes = viewModel.routes;
    return AutoTabsScaffold(
      routes: routes,
      bottomNavigationBuilder: (_, router) {
        return _BottomNavigationBarWidget(router: router);
      },
    );
  }
}

class _BottomNavigationBarWidget extends StatelessWidget {
  final TabsRouter router;

  const _BottomNavigationBarWidget({required this.router});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: viewModel.getActiveIndex(router.activeIndex),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        ...viewModel.items.map((item) {
          return BottomNavigationBarItem(icon: Icon(item.icon), label: '');
        }).toList(),
      ],
      onTap: (index) => viewModel.navigate(context, index),
    );
  }
}
