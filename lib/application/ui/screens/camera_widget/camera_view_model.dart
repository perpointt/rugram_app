import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/domain/services/camera_permission_service.dart';
import 'package:rugram/domain/services/crop_service.dart';
import 'package:rugram/domain/services/file_service.dart';

class CameraViewModel extends ChangeNotifier {
  CameraViewModel(BuildContext context) {
    _init(context);
  }

  static const kDefaultDuration = Duration(milliseconds: 150);

  final _cameraPermissionService = CameraPermissionService();
  final _cropService = CropServiceImpl();
  final _fileService = FileServiceImpl();

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

  static var _flashMode = FlashMode.off;
  FlashMode get flashMode => _flashMode;

  var _cameras = <CameraDescription>[];

  Future<void> _init(BuildContext context) async {
    final isGranted = await _cameraPermissionService.request();
    _isPermissionGranted = isGranted;
    notifyListeners();

    if (isGranted) {
      final cameras = await availableCameras();
      _cameras = cameras;
      if (_cameras.isEmpty) return;

      final description = _getCameraDescription(CameraLensDirection.back);
      if (description == null) return;

      final controller = _getCameraController(description);
      await controller.initialize();

      await controller.setFlashMode(_flashMode);
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);

      _setScale(context, controller);

      await _setZoom(controller);

      _controller = controller;
      notifyListeners();
    }
  }

  Future<void> switchFlashMode() async {
    switch (_flashMode) {
      case FlashMode.off:
        await _controller?.setFlashMode(FlashMode.always);
        _flashMode = FlashMode.always;
        notifyListeners();
        break;
      case FlashMode.always:
        await _controller?.setFlashMode(FlashMode.auto);
        _flashMode = FlashMode.auto;
        notifyListeners();
        break;
      case FlashMode.auto:
        await _controller?.setFlashMode(FlashMode.off);
        _flashMode = FlashMode.off;
        notifyListeners();
        break;
      default:
        break;
    }
  }

  Future<void> switchDescription() async {
    final controller = _controller;
    if (controller == null) return;

    final direction = controller.description.lensDirection;
    switch (direction) {
      case CameraLensDirection.front:
        final description = _getCameraDescription(CameraLensDirection.back);
        if (description == null || description.lensDirection == direction) {
          return;
        }
        await controller.setDescription(description);
        break;
      case CameraLensDirection.back:
        final description = _getCameraDescription(CameraLensDirection.front);
        if (description == null || description.lensDirection == direction) {
          return;
        }
        await controller.setDescription(description);
        break;
      default:
        break;
    }
  }

  CameraDescription? _getCameraDescription(CameraLensDirection direction) {
    if (_cameras.isEmpty) return null;

    return _cameras.firstWhere(
      (camera) => camera.lensDirection == direction,
      orElse: () => _cameras.first,
    );
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
      await newController.setFlashMode(_flashMode);
      await newController.lockCaptureOrientation(DeviceOrientation.portraitUp);

      _controller = newController;
    }
    notifyListeners();
  }

  CameraController _getCameraController(CameraDescription description) {
    const preset = ResolutionPreset.max;
    return CameraController(description, preset, enableAudio: false);
  }

  Future<void> takePicture(BuildContext context) async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    final xFile = await controller.takePicture();

    await _fileService.saveToGallery(xFile.path);

    final file = await _cropService.crop(File(xFile.path));
    AppNavigator.navigateTo(context, CreatePostRoute(files: [file]));
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
