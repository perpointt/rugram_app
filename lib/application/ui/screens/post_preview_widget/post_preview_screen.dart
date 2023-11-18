import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rugram/domain/models/post/post.dart';
import 'package:rugram/resources/resources.dart';

class PostPreviewScreen extends StatelessWidget {
  final Post post;
  const PostPreviewScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'PostPreviewScreen',
      child: CachedNetworkImage(
        imageUrl: '${AppConfig.firebaseHost}/${post.filenames.first}',
      ),
    );
  }
}
