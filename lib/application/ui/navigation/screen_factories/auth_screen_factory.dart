import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rugram/application/ui/screens/login_widget/login_screen.dart';
import 'package:rugram/application/ui/screens/register_widget/register_screen.dart';

@RoutePage()
class AuthScreenFactory extends StatelessWidget {
  const AuthScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class LoginScreenFactory extends StatelessWidget {
  const LoginScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

@RoutePage()
class RegisterScreenFactory extends StatelessWidget {
  const RegisterScreenFactory({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterScreen();
  }
}
