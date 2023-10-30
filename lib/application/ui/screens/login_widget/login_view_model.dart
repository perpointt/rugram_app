import 'package:flutter/cupertino.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/auth_service.dart';

class LoginViewModel {
  final nicknameCnrl = TextEditingController();
  final passwordCnrl = TextEditingController();

  final _service = AuthServiceImpl();

  Future<void> login(BuildContext context) async {
    await _service.login(_createRequest());
    AppNavigator.replaceNamed(AppRouteNames.app);
  }

  Map<String, String> _createRequest() {
    return {
      'username': nicknameCnrl.text,
      'password': passwordCnrl.text,
    };
  }
}
