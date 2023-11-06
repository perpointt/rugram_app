import 'dart:io';
import 'dart:typed_data';

abstract class FileService {
  Future<File> createInCache(String filePath, Uint8List bytes);
  Future<void> delete(List<File> files);
}
