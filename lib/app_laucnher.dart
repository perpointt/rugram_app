import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rugram/application/ui/app/app.dart';
import 'package:rugram/domain/database/database_client.dart';
import 'package:rugram/domain/services/path_service.dart';
import 'package:rugram/resources/resources.dart';

class AppLauncher {
  static void launch(Source source) async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    AppConfig.init(source);

    final directory = await PathServceImpl().getDirectory();
    await DatabaseClientImpl().open(directory.path);

    runApp(const App());
  }
}
