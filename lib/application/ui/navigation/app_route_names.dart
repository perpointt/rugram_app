part of 'app_navigator.dart';

abstract class AppRouteNames {
  static const app = '/app';
  static const auth = '/auth';
  static const notFound = '/404';

  static const user = 'user';
  static const welcome = 'welcome';
  static const camera = 'camera';
  static const select = 'select';
  static const post = 'post';
  static const create = 'create';

  static const login = 'login';
  static const register = 'register';

  static String join(List<String> paths) {
    return paths.join('/');
  }
}
