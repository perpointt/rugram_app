import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/footer_view.dart';
import 'package:rugram/application/ui/widgets/restricted_widget/restricted_view_model.dart';

class RestrictedWidget extends StatelessWidget {
  final String title;
  final String description;

  const RestrictedWidget({
    super.key,
    required this.title,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => RestrictedViewModel(),
      child: FooterView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        footer: const SizedBox.shrink(),
        children: [
          Text(
            title,
            style: AppTextStyle.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: AppTextStyle.primary400x06,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const _SettingsButton(),
        ],
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RestrictedViewModel>();
    return CupertinoButton(
      onPressed: viewModel.openSettings,
      child: const Text(
        'Открыть настройки',
        style: AppTextStyle.hyperlink400f14,
      ),
    );
  }
}
