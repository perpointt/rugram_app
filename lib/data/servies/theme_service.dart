abstract class ThemeService {
  Future<AppThemeMode> fetchRecentTheme();
}

enum AppThemeMode { light, dark, system }
