import 'package:flutter/cupertino.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/auth_service.dart';

class LoginViewModel {
  final username = TextEditingController();
  final password = TextEditingController();

  final _service = AuthServiceImpl();

  Future<void> login(BuildContext context) async {
    try {
      await _service.login(_createRequest());
      AppNavigator.replaceNamed(AppRouteNames.app);
    } catch (error) {}
  }

  Map<String, String> _createRequest() {
    return {
      'username': username.text,
      'password': password.text,
    };
  }
}
