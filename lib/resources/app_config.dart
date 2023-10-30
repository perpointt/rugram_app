part of 'resources.dart';
// ignore_for_file: constant_identifier_names

enum Source {
  IS_INSTALLED_FROM_PLAY_STORE,
  IS_INSTALLED_FROM_RU_STORE,
  IS_INSTALLED_FROM_APP_STORE,
}

enum Environment { develop, production, testing }

abstract class AppConfig {
  static late final Source _source;
  static Source get source => _source;

  static late final Environment _environment;

  static Environment get environment => _environment;

  static bool get isProduction => _environment == Environment.production;

  static bool get isDebug => _environment == Environment.develop;

  /// [environment] может быть null чтобы автоматически определять среду
  static void init(Source source, [Environment? environment]) {
    _source = source;

    if (environment == null) {
      _environment = kDebugMode ? Environment.develop : Environment.production;
    } else {
      _environment = environment;
    }
  }

  static const bugsnagKey = '';

  static const appMetricaKey = '';
}
