import 'package:flutter/material.dart';
import 'package:rugram/application/ui/navigation/app_navigator.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppNavigator.uri.toString()),
      ),
    );
  }
}
