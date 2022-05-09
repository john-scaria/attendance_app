import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.tabColor,
    required this.tabName,
    required this.onTabTap,
  }) : super(key: key);
  final Color tabColor;
  final String tabName;
  final VoidCallback onTabTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabTap,
      child: Container(
        color: tabColor,
        child: Text(tabName),
      ),
    );
  }
}
