import 'package:rugram/data/data_providers/version_data_provider.dart';
import 'package:rugram/data/servies/app_service.dart';

class AppServiceImpl implements AppService {
  AppServiceImpl(this.versionDataProvider);

  final VersionDataProvider versionDataProvider;

  @override
  Future<String> fetchVersion() async {
    final version = await versionDataProvider.getAppVersion();
    final buildNumber = await versionDataProvider.getBuildNumber();

    return '$version+$buildNumber';
  }
}
