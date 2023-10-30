abstract class VersionDataProvider {
  Future<String> getAppVersion();
  Future<String> getBuildNumber();
}
