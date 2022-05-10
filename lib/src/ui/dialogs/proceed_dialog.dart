import 'package:attendance_app/src/ui/widgets/proceed_dialog_widget.dart';
import 'package:flutter/material.dart';

Future<bool?> proceedDialog(
  BuildContext context, {
  required String name,
  required String subText,
}) async {
  return await showDialog<bool?>(
    context: context,
    builder: (_) => ProceedDialogWidget(
      name: name,
      subtext: subText,
    ),
  );
}
