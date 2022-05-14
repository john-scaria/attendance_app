import 'package:attendance_app/src/models/leave_model.dart';
import 'package:attendance_app/src/ui/widgets/leave_dialog_widget.dart';
import 'package:flutter/material.dart';

Future<LeaveModel?> leaveDialog(BuildContext context) async {
  return await showDialog<LeaveModel?>(
    context: context,
    builder: (_) => LeaveDialogWidget(),
  );
}
