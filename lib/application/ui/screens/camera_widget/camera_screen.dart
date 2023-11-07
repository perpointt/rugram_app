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

    return SafeArea(
      child: Transform.translate(
        offset: const Offset(0, 22),
        child: SizedBox(
          width: _size,
          height: _size,
          child: GestureDetector(
            onTap: () => context.read<CameraViewModel>().takePicture(context),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        isPermissionGranted ? Colors.white : AppColors.white06,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color:
                        isPermissionGranted ? Colors.white : AppColors.white06,
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
    final viewModel = context.watch<CameraViewModel>();
    final controller = viewModel.controller;

    if (controller == null) return const SizedBox.shrink();

    return Stack(
      children: [
        CameraPreview(
          controller,
          child: const _OverlayWidget(),
        ),
        const _SelectPhotoButton(),
        const _CameraDescriptionButton(),
        const _FlashButton(),
      ],
    );
  }
}

class _OverlayWidget extends StatelessWidget {
  const _OverlayWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        const AspectRatio(aspectRatio: 1),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                color: Colors.black.withOpacity(0.7),
              ),
              const _TakePictureButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CameraDescriptionButton extends StatelessWidget {
  const _CameraDescriptionButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        child: GestureDetector(
          onTap: context.read<CameraViewModel>().switchDescription,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.crop_rotate),
          ),
        ),
      ),
    );
  }
}

class _SelectPhotoButton extends StatelessWidget {
  const _SelectPhotoButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            AppNavigator.navigateNamedTo(context, AppRouteNames.app);
            AppNavigator.navigateTo(context, const SelectPhotoRoute());
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}

class _FlashButton extends StatelessWidget {
  const _FlashButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CameraViewModel>();
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: IconButton(
          icon: _getIcon(viewModel.flashMode),
          onPressed: viewModel.switchFlashMode,
        ),
      ),
    );
  }

  Icon _getIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return const Icon(Icons.flash_off_outlined);
      case FlashMode.always:
        return const Icon(Icons.flash_on_outlined);
      case FlashMode.auto:
        return const Icon(Icons.flash_auto_outlined);
      default:
        return const Icon(Icons.flash_on_outlined);
    }
  }
}
