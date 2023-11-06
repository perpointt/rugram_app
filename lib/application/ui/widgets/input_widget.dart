import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final EdgeInsets margin;
  final bool obscureText;

  const InputWidget({
    super.key,
    this.controller,
    this.hintText,
    this.margin = EdgeInsets.zero,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        cursorColor: Colors.white,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
