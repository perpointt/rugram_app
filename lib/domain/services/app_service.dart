import 'package:rugram/data/data_providers/version_data_provider.dart';
import 'package:rugram/data/servies/app_service.dart';
import 'package:rugram/domain/data_providers/version_data_provider.dart';

class AppServiceImpl implements AppService {
  late final VersionDataProvider versionDataProvider;

  AppServiceImpl({VersionDataProvider? versionDataProvider}) {
    this.versionDataProvider = versionDataProvider ?? VersionDataProviderImpl();
  }

  @override
  Future<String> fetchVersion() async {
    final version = await versionDataProvider.getAppVersion();
    final buildNumber = await versionDataProvider.getBuildNumber();

    return '$version+$buildNumber';
  }
}
