import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final EdgeInsets margin;

  const InputWidget({
    super.key,
    this.controller,
    this.labelText,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
