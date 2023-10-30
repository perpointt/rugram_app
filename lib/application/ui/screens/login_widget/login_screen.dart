import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppNavigator.uri.toString()),
      ),
    );
  }
}
