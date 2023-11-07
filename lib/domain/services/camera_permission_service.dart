import 'package:permission_handler/permission_handler.dart';
import 'package:rugram/data/servies/permission_service.dart';

class CameraPermissionService implements PermissionService {
  @override
  Future<bool> isGranted() {
    return Permission.camera.isGranted;
  }

  @override
  Future<bool> request() {
    return Permission.camera.request().isGranted;
  }
}
