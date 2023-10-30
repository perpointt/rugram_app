import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/themes/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp.router(
        routerConfig: AppNavigator.instance.config(
          navigatorObservers: () => [NavObserver()],
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru', 'RU')],
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        builder: (context, child) {
          return _AppObserver(
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _AppObserver extends StatelessWidget {
  final Widget child;
  const _AppObserver({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child,
      ),
    );
  }
}
