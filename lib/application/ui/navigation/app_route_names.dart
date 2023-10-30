part of 'app_navigator.dart';

abstract class AppRouteNames {
  static const app = '/app';
  static const auth = '/auth';
  static const notFound = '/404';

  static const profile = 'profile';
  static const welcome = 'welcome';
  static const camera = 'camera';
  static const select = 'select';

  static String join(List<String> paths) {
    return paths.join('/');
  }
}
