import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:rugram/data/servies/file_service.dart';

class FileServiceImpl implements FileService {
  @override
  Future<File> createInCache(String filePath, Uint8List bytes) async {
    final directory = await _fetchDirectory();

    final name = path.basename(filePath);
    final absolutePath = path.absolute(directory.path, name);

    final file = File(absolutePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<Directory> _fetchDirectory() {
    return path_provider.getApplicationCacheDirectory();
  }

  @override
  Future<void> delete(List<File> files) async {
    await Future.forEach(files, (file) async {
      await file.delete();
    });
  }
}

extension FileExt on File {
  bool get isImage {
    final extension = path.extension(this.path).replaceAll('.', '');
    return ['png, jpeg', 'jpg'].contains(extension);
  }
}
