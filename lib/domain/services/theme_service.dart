import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:rugram/data/servies/theme_service.dart';

class ThemeServiceImpl implements ThemeService {
  @override
  Future<AppThemeMode> fetchRecentTheme() async {
    final theme = await AdaptiveTheme.getThemeMode();

    return (theme ?? AdaptiveThemeMode.system).toThemMode();
  }
}

extension AdaptiveThemeModeExt on AdaptiveThemeMode {
  AppThemeMode toThemMode() {
    switch (this) {
      case AdaptiveThemeMode.dark:
        return AppThemeMode.dark;
      case AdaptiveThemeMode.light:
        return AppThemeMode.light;
      case AdaptiveThemeMode.system:
        return AppThemeMode.system;
    }
  }
}

extension ThemeModeExt on AppThemeMode {
  AdaptiveThemeMode toThemMode() {
    switch (this) {
      case AppThemeMode.dark:
        return AdaptiveThemeMode.dark;
      case AppThemeMode.light:
        return AdaptiveThemeMode.light;
      case AppThemeMode.system:
        return AdaptiveThemeMode.system;
    }
  }
}
