import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key);
  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(buttonText),
    );
  }
}
