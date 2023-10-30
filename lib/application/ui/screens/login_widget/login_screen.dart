import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/login_widget/login_view_model.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/buttons/buttons.dart';
import 'package:rugram/application/ui/widgets/input_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Вход',
            style: AppTextStyle.primary,
          ),
          const SizedBox(height: 16),
          const InputWidget(
            margin: EdgeInsets.all(16),
            labelText: 'Логин',
          ),
          const InputWidget(
            margin: EdgeInsets.all(16),
            labelText: 'Пароль',
          ),
          CustomButton(
            margin: const EdgeInsets.all(16),
            title: 'Войти',
            onTap: () => viewModel.login(context),
          ),
          CustomButton(
            background: AppColors.grey400,
            margin: const EdgeInsets.all(16),
            title: 'Регистрация',
            onTap: () {
              AppNavigator.navigateNamedTo(context, AppRouteNames.register);
            },
          ),
        ],
      ),
    );
  }
}
