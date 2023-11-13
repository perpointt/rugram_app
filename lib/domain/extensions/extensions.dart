import 'package:path/path.dart' as path;

extension StringExt on String {
  bool get isImage {
    final extension = path.extension(this);
    return ['.png', '.jpg', '.jpeg'].contains(extension);
  }
}
