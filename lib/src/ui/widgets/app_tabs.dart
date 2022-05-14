import 'package:attendance_app/src/ui/widgets/tab_widget.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  const AppTabs({Key? key, required this.tabWidget}) : super(key: key);
  final List<TabWidget> tabWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          border: Border.all(color: Colors.black)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: tabWidget,
        ),
      ),
    );
  }
}
