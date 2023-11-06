import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/screens/create_post_widget/create_post_view_model.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New post'),
        actions: [
          CupertinoButton(
            onPressed: () {
              context.read<CreatePostViewModel>().create(context);
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
}
