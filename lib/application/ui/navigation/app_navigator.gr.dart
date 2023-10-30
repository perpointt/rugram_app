// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_navigator.dart';

abstract class _$_Router extends RootStackRouter {
  // ignore: unused_element
  _$_Router({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AppRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppScreenFactory(),
      );
    },
    CameraRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CameraScreenFactory(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreenFactory(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreenFactory(),
      );
    },
    SelectPhotoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SelectPhotoScreenFactory(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeScreenFactory(),
      );
    },
  };
}

/// generated route for
/// [AppScreenFactory]
class AppRoute extends PageRouteInfo<void> {
  const AppRoute({List<PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CameraScreenFactory]
class CameraRoute extends PageRouteInfo<void> {
  const CameraRoute({List<PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreenFactory]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreenFactory]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SelectPhotoScreenFactory]
class SelectPhotoRoute extends PageRouteInfo<void> {
  const SelectPhotoRoute({List<PageRouteInfo>? children})
      : super(
          SelectPhotoRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectPhotoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeScreenFactory]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
