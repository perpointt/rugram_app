import 'dart:io';

import 'package:rugram/data/servies/crop_service.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rugram/domain/models/app_exception.dart';

class CropServiceImpl implements CropService {
  static const _side = 1800;
  @override
  Future<File> crop(File file, [int? side]) async {
    final image = await img.decodeImageFile(file.path);
    if (image == null) throw AppException(error: 'Unable to decode image');
    final croppedImage = img.copyResizeCropSquare(image, size: _side);
    final croppedFile = await _convertImageToFile(croppedImage, file.path);
    return croppedFile;
  }

  Future<File> _convertImageToFile(img.Image image, String path) async {
    final newPath = await _croppedFilePath(path);
    final jpegBytes = img.encodeJpg(image);

    final convertedFile = await File(newPath).writeAsBytes(jpegBytes);
    await File(path).delete();
    return convertedFile;
  }

  Future<String> _croppedFilePath(String path) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = '${basenameWithoutExtension(path)}_compressed.jpg';
    return join(tempDir.path, fileName);
  }
}
