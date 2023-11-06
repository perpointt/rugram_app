import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/widgets/restricted_widget/restricted_widget.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RestrictedWidget(
            title: 'Разрешите Rugram доступ к вашей камере и микрофону',
            description:
                'Это позволит вам обмениваться фотографиями и записывать видео.',
          ),
          SafeArea(
            child: CloseButton(
              onPressed: () {
                AppNavigator.navigateNamedTo(context, AppRouteNames.app);
              },
            ),
          ),
        ],
      ),
    );
  }
}
