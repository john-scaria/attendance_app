import 'package:attendance_app/src/models/student_profile_model.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_qr_view.dart';
import 'package:attendance_app/src/ui/widgets/profile_pic.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/src/ui/dialogs/leave_dialog.dart'
    as leave_dialog;

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key, required this.studentData}) : super(key: key);
  final StudentProfileModel studentData;

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = context.read<ProfileViewModel>();
    return Column(
      children: [
        const ProfilePic(),
        Constants.verticalSpacer5,
        Text(
          studentData.fullName,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Constants.verticalSpacer5,
        Text(
          _profileViewModel.userId ?? '',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        Constants.verticalSpacer5,
        Text(
          'Dept: ${studentData.department}, Sem: ${studentData.semester}',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Constants.verticalSpacer15,
        AppQrView(
          data: Utils.setQrCode(
            _profileViewModel.userId,
            Utils.getLoginTypeFromEnum(_profileViewModel.userType),
          ),
        ),
        /* Text('Roll No.: ${studentData.rollNo}'),
        Constants.verticalSpacer10,
        const Text('Student'), */
      ],
    );
  }
}
