import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/auth_service.dart';

class RegisterViewModel {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final _service = AuthServiceImpl();

  Future<void> register(BuildContext context) async {
    try {
      await _service.register(_createRequest());
      AppNavigator.replaceNamed(AppRouteNames.app);
    } catch (error) {}
  }

  Map<String, String> _createRequest() {
    return {
      'username': username.text,
      'email': email.text,
      'password': password.text,
    };
  }
}
