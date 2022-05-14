import 'package:attendance_app/src/models/leave_model.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveDialogWidget extends StatelessWidget {
  LeaveDialogWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = context.read<ProfileViewModel>();
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Leave',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Constants.verticalSpacer15,
            AppTextField(
              fillColor: Colors.grey.withOpacity(0.2),
              maxLines: 3,
              textEditingController:
                  _profileViewModel.leaveReasonTextFieldController,
              hintText: 'Reason',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Reason cannot be Empty';
                }
                return null;
              },
            ),
            Constants.verticalSpacer8,
            AppButton(
              buttonColor: Colors.grey.withOpacity(0.5),
              textColor: Colors.black,
              buttonText: context.watch<ProfileViewModel>().currentDate,
              onTap: () async {
                final _date = await _profileViewModel.getDate(
                  context: context,
                  initialDate: _profileViewModel.currentDate,
                );
                if (_date != null) {
                  _profileViewModel.setCurrentDate(
                    Utils.timeToddMMyyyyString(_date),
                  );
                }
              },
            ),
            Constants.verticalSpacer8,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    buttonColor: Colors.white,
                    borderSideColor: Colors.black,
                    textColor: Colors.black,
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
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          LeaveModel(
                            reason: _profileViewModel
                                .leaveReasonTextFieldController.text,
                            date: _profileViewModel.currentDate,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
