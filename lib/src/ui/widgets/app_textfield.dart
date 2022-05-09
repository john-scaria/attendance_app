import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
