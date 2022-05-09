import 'package:attendance_app/src/models/leave_model.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProceedDialogWidget extends StatelessWidget {
  const ProceedDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Proceed?'),
          Text('Name: John Doe'),
          Text('Department: CSE'),
          Text('Semester: S1'),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  buttonText: 'Cancel',
                  onTap: () => Navigator.pop(context, false),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: AppButton(
                  buttonText: 'Send',
                  onTap: () => Navigator.pop(
                    context,
                    true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
