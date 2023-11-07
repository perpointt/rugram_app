import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/camera_widget/camera_view_model.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/restricted_widget/restricted_widget.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isPermissionGranted = context.select<CameraViewModel, bool>((value) {
      return value.isPermissionGranted;
    });
    return Scaffold(
      body: Stack(
        children: [
          if (isPermissionGranted) const _CameraWidget(),
          if (!isPermissionGranted) ...[
            const RestrictedWidget(
              title: 'Разрешите Rugram доступ к вашей камере и микрофону',
              description:
                  'Это позволит вам обмениваться фотографиями и записывать видео.',
            ),
          ],
          SafeArea(
            child: CloseButton(
              onPressed: () {
                AppNavigator.navigateNamedTo(context, AppRouteNames.app);
              },
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: _TakePictureButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TakePictureButton extends StatelessWidget {
  const _TakePictureButton();

  static const _size = 70.0;

  @override
  Widget build(BuildContext context) {
    final isPermissionGranted = context.select<CameraViewModel, bool>((value) {
      return value.isPermissionGranted;
    });

    return Container(
      width: _size,
      height: _size,
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: context.read<CameraViewModel>().takePicture,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isPermissionGranted ? Colors.white : AppColors.white06,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isPermissionGranted ? Colors.white : AppColors.white06,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraWidget extends StatefulWidget {
  const _CameraWidget({Key? key}) : super(key: key);

  @override
  State<_CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<_CameraWidget>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    context.read<CameraViewModel>().didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    final viewModel = context.watch<CameraViewModel>();
    final controller = viewModel.controller;
    final scale = viewModel.scale;

    if (controller == null) return const SizedBox.shrink();

    return ClipRect(
      clipper: _MediaSizeClipper(mediaSize),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: CameraPreview(controller),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
