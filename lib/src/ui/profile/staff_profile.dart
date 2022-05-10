import 'package:attendance_app/src/models/staff_profile_model.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/profile_pic.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:attendance_app/src/ui/dialogs/leave_dialog.dart'
    as leave_dialog;

class StaffProfile extends StatelessWidget {
  const StaffProfile({
    Key? key,
    required this.staffProfileModel,
  }) : super(key: key);
  final StaffProfileModel staffProfileModel;

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = context.read<ProfileViewModel>();
    return Column(
      children: [
        const ProfilePic(),
        Text(staffProfileModel.fullName),
        Text(_profileViewModel.userId ?? ''),
        Text(staffProfileModel.type),
        QrImage(
          data: Utils.setQrCode(
            _profileViewModel.userId,
            Utils.getLoginTypeFromEnum(_profileViewModel.userType),
          ),
          version: QrVersions.auto,
          size: 130.0,
        ),
        AppButton(
          onTap: () async {
            final _leaveData = await leave_dialog.leaveDialog(context);
            if (_leaveData != null) {}
          },
          buttonText: 'Apply Leave',
        ),
      ],
    );
  }
}
