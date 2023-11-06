import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/login_widget/login_view_model.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/buttons/buttons.dart';
import 'package:rugram/application/ui/widgets/divider_widget.dart';
import 'package:rugram/application/ui/widgets/input_widget.dart';
import 'package:rugram/application/ui/widgets/safe_area_bottom_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text(
            'Rugram',
            style: TextStyle(
              fontSize: 36,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 40),
          InputWidget(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'Username',
            controller: viewModel.username,
          ),
          const SizedBox(height: 12),
          InputWidget(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'Password',
            obscureText: true,
            controller: viewModel.password,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: HyperlinkWidget(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              text: 'Forgot password?',
              onTap: () {},
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            title: 'Log in',
            onTap: () => viewModel.login(context),
          ),
          const SizedBox(height: 40),
          Center(
            child: HyperlinkWidget(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              text: 'Sign up',
              onTap: () {
                AppNavigator.navigateNamedTo(context, AppRouteNames.register);
              },
              prefix: const ['Don’t have an account? '],
              hyperlinkStyle: AppTextStyle.hyperlink400f14,
            ),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          const DividerWidget(
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 32),
          const Text(
            'Rugram from Машинки',
            style: AppTextStyle.primary400x06,
          ),
          const SafeAreaBottomWidget(height: 32),
        ],
      ),
    );
  }
}
