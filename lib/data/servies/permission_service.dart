abstract class PermissionService {
  Future<bool> request();
  Future<bool> isGranted();
}
