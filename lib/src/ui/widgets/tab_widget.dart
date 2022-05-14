import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.tabColor,
    required this.tabName,
    required this.onTabTap,
    this.textColor,
  }) : super(key: key);
  final Color tabColor;
  final String tabName;
  final VoidCallback onTabTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabTap,
      child: Container(
        color: tabColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tabName,
            style: TextStyle(
              color: textColor,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
