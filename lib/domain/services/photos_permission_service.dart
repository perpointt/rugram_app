import 'package:permission_handler/permission_handler.dart';
import 'package:rugram/data/servies/permission_service.dart';

class PhotosPermissionService implements PermissionService {
  @override
  Future<bool> isGranted() {
    return Permission.photos.request().isGranted;
  }

  @override
  Future<bool> request() {
    return Permission.photos.isGranted;
  }
}
