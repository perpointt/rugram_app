import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/login_widget/login_screen.dart';
import 'package:rugram/application/ui/screens/login_widget/login_view_model.dart';
import 'package:rugram/application/ui/screens/register_widget/register_screen.dart';
import 'package:rugram/application/ui/screens/register_widget/register_view_model.dart';

@RoutePage()
class AuthScreenFactory extends StatelessWidget {
  const AuthScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.unfocus(context),
      child: const AutoRouter(),
    );
  }
}

@RoutePage()
class LoginScreenFactory extends StatelessWidget {
  const LoginScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => LoginViewModel(),
      child: const LoginScreen(),
    );
  }
}

@RoutePage()
class RegisterScreenFactory extends StatelessWidget {
  const RegisterScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => RegisterViewModel(),
      child: const RegisterScreen(),
    );
  }
}
