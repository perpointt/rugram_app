import 'package:flutter/material.dart';

class SafeAreaBottomWidget extends StatelessWidget {
  final double height;
  const SafeAreaBottomWidget({super.key, this.height = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: _calc(context));
  }

  double _calc(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    if (padding.bottom > height) {
      return padding.bottom;
    } else {
      return height;
    }
  }
}
