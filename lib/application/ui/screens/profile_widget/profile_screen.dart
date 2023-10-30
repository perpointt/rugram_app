import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/profile_widget/profile_view_model.dart';
import 'package:rugram/application/ui/widgets/buttons/buttons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppNavigator.uri.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            margin: const EdgeInsets.all(16),
            title: 'Выйти',
            onTap: () => viewModel.logout(context),
          ),
        ],
      ),
    );
  }
}
