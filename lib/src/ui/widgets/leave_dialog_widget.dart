import 'package:attendance_app/src/models/leave_model.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveDialogWidget extends StatelessWidget {
  const LeaveDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = context.read<ProfileViewModel>();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Leave'),
          AppTextField(
            textEditingController:
                _profileViewModel.leaveReasonTextFieldController,
            hintText: 'Reason',
          ),
          AppButton(
            buttonText: '20/1/2022',
            onTap: () {},
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  buttonText: 'Cancel',
                  onTap: () => Navigator.pop(context, null),
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
                    const LeaveModel(
                      reason: 'abc',
                      date: '20/1/2022',
                    ),
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
