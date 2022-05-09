import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
