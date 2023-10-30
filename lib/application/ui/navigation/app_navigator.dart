export 'package:auto_route/auto_route.dart';
export 'package:oktoast/oktoast.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rugram/application/ui/navigation/screen_factories/screen_factory.dart';
import 'package:rugram/application/ui/widgets/loader.dart';
import 'package:oktoast/oktoast.dart' as oktoast;

part 'app_navigator.gr.dart';
part 'app_route_names.dart';

// flutter packages pub run build_runner build
@AutoRouterConfig(
  replaceInRouteName: 'ScreenFactory,Route',
)
class _Router extends _$_Router {
  _Router() : super();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: AppRouteNames.app,
      page: AppRoute.page,
      initial: true,
      children: [
        AutoRoute(
          path: '',
          page: HomeRoute.page,
          initial: true,
          maintainState: false,
          children: [
            AutoRoute(
              path: AppRouteNames.welcome,
              page: WelcomeRoute.page,
              initial: true,
            ),
            AutoRoute(
              path: AppRouteNames.profile,
              page: ProfileRoute.page,
            ),
          ],
        ),
      ],
    ),
    RedirectRoute(
      path: AppRouteNames.app,
      redirectTo: AppRouteNames.join(
        [AppRouteNames.app, AppRouteNames.welcome],
      ),
    ),
    RedirectRoute(path: '*', redirectTo: AppRouteNames.notFound),
  ];
}

abstract class AppNavigator {
  static final _router = _Router();

  // ignore: library_private_types_in_public_api
  static _Router get instance => _router;

  static Uri get uri => _router.navigationHistory.urlState.uri;

  static Map<String, String> get queryParameters =>
      _router.navigationHistory.urlState.uri.queryParameters;

  static bool _isDialogOpened = false;

  static bool get isDialogOpened => _isDialogOpened;

  static void unfocus(BuildContext context) {
    return FocusScope.of(context).unfocus();
  }

  static Future<void> closeDialog() async {
    if (_isDialogOpened) {
      _isDialogOpened = false;
      _router.popTop();
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  static void openDialog({
    required BuildContext context,
    required Widget dialog,
    bool barrierDismissible = true,
    Color barrierColor = Colors.black54,
    bool maintainState = true,
  }) async {
    await closeDialog();
    _isDialogOpened = true;

    await _router.pushNativeRoute(
      DialogRoute(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        builder: (_) => dialog,
      ),
    );

    if (maintainState) _isDialogOpened = false;
  }

  static Future<void> openLoadingDialog(BuildContext context) async {
    await closeDialog();
    return openDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.5),
      barrierDismissible: false,
      dialog: const Loader(),
      maintainState: false,
    );
  }

  static void dismissToast() {
    oktoast.dismissAllToast();
  }

  static oktoast.ToastFuture toast(
    Widget child, {
    EdgeInsets padding = const EdgeInsets.only(right: 16),
  }) {
    return oktoast.showToastWidget(
      child,
      handleTouch: true,
      dismissOtherToast: true,
      duration: const Duration(seconds: 2),
    );
  }

  static Future<void> openBottomSheet(
    BuildContext context,
    Widget Function(BuildContext) builder, {
    ShapeBorder? shape,
  }) async {
    await closeDialog();
    _isDialogOpened = true;
    return showModalBottomSheet(
      context: context,
      builder: builder,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: shape,
    ).then((value) {
      _isDialogOpened = false;
      return value;
    });
  }

  static bool canPop() {
    return _router.canPop();
  }

  static Future<bool> pop<T>([T? result]) async {
    if (canPop()) {
      await closeDialog();
      return _router.popTop(result);
    }
    return false;
  }

  static Future<T?> pushNamed<T>(
    String path, {
    Map<String, String> queryParameters = const {},
  }) async {
    final uri = Uri(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
    await closeDialog();
    return _router.pushNamed(uri.toString());
  }

  static Future<T?> push<T>(PageRouteInfo route) async {
    await closeDialog();
    return _router.push(route);
  }

  static Future<T?> replaceNamed<T>(
    String path, {
    Map<String, String> queryParameters = const {},
  }) async {
    final uri = Uri(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
    await closeDialog();
    return _router.replaceNamed(uri.toString());
  }

  static Future<T?> replace<T>(PageRouteInfo route) async {
    await closeDialog();
    return _router.replace(route);
  }

  static Future<void> navigateTo(
      BuildContext context, PageRouteInfo route) async {
    await closeDialog();
    return context.navigateTo(route);
  }

  static Future<void> navigateNamedTo(
    BuildContext context,
    String path, {
    Map<String, String> queryParameters = const {},
  }) async {
    final uri = Uri(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );

    await closeDialog();
    return context.navigateNamedTo(uri.toString());
  }
}

extension StackRouterExt on StackRouter {
  String get activePath {
    final segments = currentPath.split('/');
    return segments.lastOrNull ?? currentPath;
  }

  String get previousPath {
    final path = currentPath;
    final segments = path.split('/');
    if (segments.isEmpty) return currentPath;
    segments.removeLast();
    return segments.join('/');
  }

  String get activeRoot {
    final segments = currentPath.split('/');
    if (segments.isEmpty) return currentPath;

    segments.removeAt(0);

    if (segments.isEmpty) return currentPath;

    final root = segments.firstOrNull;
    if (root == null) return currentPath;
    return '/$root';
  }
}

class NavObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('New route pushed: ${AppNavigator.uri}');
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (kDebugMode) {
      print('Tab route visited: ${AppNavigator.uri}');
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (kDebugMode) {
      print('Tab route re-visited: ${AppNavigator.uri}');
    }
  }
}
