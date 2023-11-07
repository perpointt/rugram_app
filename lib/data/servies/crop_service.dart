import 'dart:io';

abstract class CropService {
  Future<File> crop(File file, [int? side]);
}
