part of 'guards.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = await AuthServiceImpl().isAuthenticated();
    if (isAuthenticated) {
      router.pushNamed(AppRouteNames.app);
    } else {
      resolver.next();
    }
  }
}
