import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/register_widget/register_view_model.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/buttons/buttons.dart';
import 'package:rugram/application/ui/widgets/divider_widget.dart';
import 'package:rugram/application/ui/widgets/footer_view.dart';
import 'package:rugram/application/ui/widgets/input_widget.dart';
import 'package:rugram/application/ui/widgets/safe_area_bottom_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterViewModel>();
    return Scaffold(
      body: FooterView(
        footer: const Column(
          children: [
            DividerWidget(
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(height: 32),
            Text(
              'Rugram from Машинки',
              style: AppTextStyle.primary400x06,
            ),
            SafeAreaBottomWidget(height: 32),
          ],
        ),
        children: [
          const Text(
            'Rugram',
            style: TextStyle(
              fontSize: 36,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Зарегистрируйтесь, чтобы смотреть\nфото и видео ваших друзей.',
            style: AppTextStyle.primary400x06,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          InputWidget(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'Nickname',
            controller: viewModel.username,
          ),
          const SizedBox(height: 12),
          InputWidget(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'Email',
            controller: viewModel.email,
          ),
          const SizedBox(height: 12),
          InputWidget(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'Password',
            controller: viewModel.password,
          ),
          const SizedBox(height: 20),
          CustomButton(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            title: 'Sign up',
            onTap: () => viewModel.register(context),
          ),
          const SizedBox(height: 40),
          Center(
            child: HyperlinkWidget(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              text: 'Log in',
              onTap: () {
                AppNavigator.navigateNamedTo(context, AppRouteNames.login);
              },
              prefix: const ['Have an account? '],
              hyperlinkStyle: AppTextStyle.hyperlink400f14,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
