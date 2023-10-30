part of 'guards.dart';

class AppGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = await AuthServiceImpl().isAuthenticated();
    if (isAuthenticated) {
      resolver.next();
    } else {
      router.pushNamed(AppRouteNames.auth);
    }
  }
}
