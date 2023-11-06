import 'package:flutter/material.dart';
import 'package:rugram/application/ui/themes/themes.dart';

class DividerWidget extends StatelessWidget {
  final EdgeInsets margin;
  const DividerWidget({
    super.key,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: 1,
      color: AppColors.divider,
    );
  }
}
