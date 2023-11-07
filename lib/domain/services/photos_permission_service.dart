import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rugram/data/servies/permission_service.dart';

class PhotosPermissionService implements PermissionService {
  @override
  Future<bool> isGranted() async {
    if (Platform.isAndroid) {
      final permission = await _getPermissionForAndroid();
      return permission.isGranted;
    }

    return Permission.photos.isGranted;
  }

  @override
  Future<bool> request() async {
    if (Platform.isAndroid) {
      final permission = await _getPermissionForAndroid();
      return permission.request().isGranted;
    }

    return Permission.photos.request().isGranted;
  }

  Future<Permission> _getPermissionForAndroid() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;
    return (sdkInt >= 33 ? Permission.photos : Permission.storage);
  }
}
