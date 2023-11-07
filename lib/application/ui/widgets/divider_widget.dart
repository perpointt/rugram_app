import 'package:flutter/material.dart';
import 'package:rugram/application/ui/themes/themes.dart';

class DividerWidget extends StatelessWidget {
  final EdgeInsets margin;
  final double height;
  const DividerWidget({
    super.key,
    this.margin = EdgeInsets.zero,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: height,
      color: AppColors.divider,
    );
  }
}
