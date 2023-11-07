import 'package:flutter/cupertino.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.username);

  final _authService = AuthServiceImpl();

  final String username;

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    AppNavigator.replaceNamed(AppRouteNames.auth);
  }
}
