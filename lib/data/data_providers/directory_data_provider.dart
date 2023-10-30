import 'dart:io';

abstract class DirectoryDataProvider {
  Future<Directory> getDirectory();
}
