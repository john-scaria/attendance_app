import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.horizontalPadding = 10.0,
    this.buttonColor = const Color(0xFF0CB4CB),
    this.textColor = Colors.white,
    this.borderSideColor = const Color(0xFF0CB4CB),
  }) : super(key: key);
  final VoidCallback onTap;
  final String buttonText;
  final double horizontalPadding;
  final Color buttonColor;
  final Color textColor;
  final Color borderSideColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: buttonColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              onPressed: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
