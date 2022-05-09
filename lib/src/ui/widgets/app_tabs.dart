import 'package:attendance_app/src/ui/widgets/tab_widget.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  const AppTabs({Key? key, required this.tabWidget}) : super(key: key);
  final List<TabWidget> tabWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: tabWidget,
    );
  }
}
