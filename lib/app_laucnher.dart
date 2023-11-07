import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rugram/application/ui/app/app.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/services/path_service.dart';
import 'package:rugram/domain/services/theme_service.dart';
import 'package:rugram/resources/resources.dart';

class AppLauncher {
  static void launch(Source source) async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    AppConfig.init(source);

    final directory = await PathServceImpl().getDirectory();
    await DatabaseClientImpl().open(directory.path);
    final theme = await ThemeServiceImpl().fetchRecentTheme();

    runApp(App(theme: theme));
  }
}
