import 'package:package_info_plus/package_info_plus.dart';
import 'package:rugram/data/data_providers/version_data_provider.dart';

class VersionDataProviderImpl implements VersionDataProvider {
  @override
  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<String> getBuildNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}
