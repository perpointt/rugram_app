import 'dart:io';

import 'package:rugram/data/data_providers/directory_data_provider.dart';
import 'package:rugram/data/servies/path_service.dart';
import 'package:rugram/domain/data_providers/directory_data_provider.dart';

class PathServceImpl implements PathServce {
  late final DirectoryDataProvider directoryDataProvider;

  PathServceImpl({DirectoryDataProvider? directoryDataProvider}) {
    this.directoryDataProvider =
        directoryDataProvider ?? DirectoryDataProviderImpl();
  }

  @override
  Future<Directory> getDirectory() {
    return directoryDataProvider.getDirectory();
  }
}
