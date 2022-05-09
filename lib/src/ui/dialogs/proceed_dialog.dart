import 'package:attendance_app/src/ui/widgets/proceed_dialog_widget.dart';
import 'package:flutter/material.dart';

Future<bool?> proceedDialog(BuildContext context) async {
  return await showDialog<bool?>(
    context: context,
    builder: (_) => const ProceedDialogWidget(),
  );
}
