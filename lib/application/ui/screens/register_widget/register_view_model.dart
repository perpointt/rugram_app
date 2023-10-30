import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/auth_service.dart';

class RegisterViewModel {
  final nicknameCnrl = TextEditingController();
  final emailCnrl = TextEditingController();
  final passwordCnrl = TextEditingController();

  final _service = AuthServiceImpl();

  Future<void> register(BuildContext context) async {
    await _service.register(_createRequest());
    AppNavigator.replaceNamed(AppRouteNames.app);
  }

  Map<String, String> _createRequest() {
    return {
      'username': nicknameCnrl.text,
      'email': emailCnrl.text,
      'password': passwordCnrl.text,
    };
  }
}
