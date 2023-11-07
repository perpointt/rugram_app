import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/data/servies/theme_service.dart';
import 'package:rugram/domain/services/theme_service.dart';

class App extends StatelessWidget {
  final AppThemeMode theme;
  const App({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: theme.toThemMode(),
      light: AppTheme.light,
      dark: AppTheme.dark,
      debugShowFloatingThemeButton: true,
      builder: (theme, darkTheme) => MaterialApp.router(
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
        theme: theme,
        darkTheme: AppTheme.dark,
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
