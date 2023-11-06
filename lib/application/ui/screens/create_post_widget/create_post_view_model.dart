import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rugram/domain/services/file_service.dart';
import 'package:rugram/domain/services/post_service.dart';

class CreatePostViewModel {
  CreatePostViewModel(this.files);

  final _postService = PostServiceImpl();
  final _fileService = FileServiceImpl();

  final List<File> files;
  final description = TextEditingController();

  Future<void> create(BuildContext context) async {
    try {
      await _postService.create(_createRequest());
      await _fileService.delete(files);
    } catch (error) {}
  }

  Map<String, dynamic> _createRequest() {
    return {
      'images': files,
      'caption': description.text,
    };
  }
}
