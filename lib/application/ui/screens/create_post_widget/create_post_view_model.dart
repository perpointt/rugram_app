import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rugram/domain/services/post_service.dart';

class CreatePostViewModel {
  CreatePostViewModel(this.images);

  final _service = PostServiceImpl();

  final List<File> images;
  final description = TextEditingController();

  Future<void> create(BuildContext context) async {
    try {
      _service.create(_createRequest());
    } catch (error) {
      print(error);
    }
  }

  Map<String, dynamic> _createRequest() {
    return {
      'images': images,
      'caption': 'sample caption',
    };
  }
}
