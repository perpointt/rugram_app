import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';
import 'package:rugram/application/ui/screens/create_post_widget/create_post_view_model.dart';
import 'package:rugram/application/ui/widgets/divider_widget.dart';
import 'package:rugram/application/ui/widgets/input_widget.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreatePostViewModel>();
    return GestureDetector(
      onTap: () => AppNavigator.unfocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New post'),
          actions: [
            CupertinoButton(
              onPressed: () => viewModel.create(context),
              child: const Text('Share'),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.file(
                        viewModel.files.first,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: InputWidget(
                      controller: viewModel.description,
                      decoration: const InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: 'Write a caption',
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const DividerWidget(),
          ],
        ),
      ),
    );
  }
}
