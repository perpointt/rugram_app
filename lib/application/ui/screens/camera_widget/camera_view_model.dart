import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/camera_permission_service.dart';
import 'package:rugram/domain/services/file_service.dart';
import 'package:rugram/resources/resources.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraViewModel extends ChangeNotifier {
  CameraViewModel(BuildContext context) {
    _init(context);
  }

  static const kDefaultDuration = Duration(milliseconds: 150);

  final _cameraPermissionService = CameraPermissionService();

  CameraController? _controller;
  CameraController? get controller => _controller;

  double _scale = 1.0;
  double get scale => _scale;

  double _minZoomLevel = 1.0;
  double get minZoomLevel => _minZoomLevel * 10;

  double _maxZoomLevel = 10;
  double get maxZoomLevel => _maxZoomLevel * 10;

  double _zoomLevel = 1.0;
  double get zoomLevel => _zoomLevel * 10;

  double _previousZoomLevel = 1.0;

  bool _isPermissionGranted = false;
  bool get isPermissionGranted => _isPermissionGranted;

  Future<void> _init(BuildContext context) async {
    final isGranted = await _cameraPermissionService.request();
    _isPermissionGranted = isGranted;
    notifyListeners();

    if (isGranted) {
      final cameras = await availableCameras();

      if (cameras.isEmpty) return;

      final CameraDescription description = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = _getCameraController(description);
      await controller.initialize();
      await controller.setFlashMode(FlashMode.off);
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);

      _setScale(context, controller);

      await _setZoom(controller);

      _controller = controller;
      notifyListeners();
    }
  }

  void onScaleStart(ScaleStartDetails details) {
    _previousZoomLevel = _zoomLevel;
  }

  Future<void> onScaleUpdate(ScaleUpdateDetails details) async {
    if (details.pointerCount < 2) return;

    final scale = _previousZoomLevel * details.scale;
    final calculated = scale.clamp(1.0, _maxZoomLevel);
    _zoomLevel = calculated;
    await _controller?.setZoomLevel(calculated);
    notifyListeners();
  }

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (Platform.isIOS) return;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      final description = controller.description;
      final newController = _getCameraController(description);

      await newController.initialize();
      await newController.setZoomLevel(_zoomLevel);
      await newController.setFlashMode(FlashMode.off);
      await newController.lockCaptureOrientation(DeviceOrientation.portraitUp);

      _controller = newController;
    }
    notifyListeners();
  }

  CameraController _getCameraController(CameraDescription description) {
    const preset = ResolutionPreset.max;
    return CameraController(description, preset, enableAudio: false);
  }

  Future<void> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    final _ = await controller.takePicture();
  }

  Future<void> _setZoom(CameraController controller) async {
    final minZoom = await controller.getMinZoomLevel();
    final maxZoom = await controller.getMaxZoomLevel();
    final calculatedMaxZoom = math.min(maxZoom, 12);
    _minZoomLevel = minZoom;
    _maxZoomLevel = maxZoom.clamp(minZoom, calculatedMaxZoom).toDouble();
    _zoomLevel = minZoom;

    return controller.setZoomLevel(minZoom);
  }

  void _setScale(BuildContext context, CameraController controller) {
    final aspectRatio = controller.value.aspectRatio;

    final mediaSize = MediaQuery.of(context).size;
    final scale = 1 / (aspectRatio * mediaSize.aspectRatio);
    _scale = scale < 1 ? 1 : scale;
  }

  Future<void> setZoomLevel(double value) async {
    final calculated = value / 10;

    if (_controller == null) return;
    await _controller?.setZoomLevel(calculated);
    _zoomLevel = calculated;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
