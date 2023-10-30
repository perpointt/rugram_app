import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:rugram/data/data_providers/directory_data_provider.dart';

class DirectoryDataProviderImpl implements DirectoryDataProvider {
  @override
  Future<Directory> getDirectory() {
    return path_provider.getApplicationCacheDirectory();
  }
}
