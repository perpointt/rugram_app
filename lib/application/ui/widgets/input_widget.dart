import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final EdgeInsets margin;
  final bool obscureText;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final int maxLines;
  final int? minLines;

  const InputWidget({
    super.key,
    this.controller,
    this.hintText,
    this.margin = EdgeInsets.zero,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        cursorColor: Colors.white,
        controller: controller,
        decoration: decoration ?? InputDecoration(hintText: hintText),
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
      ),
    );
  }
}
