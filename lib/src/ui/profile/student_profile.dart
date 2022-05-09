import 'package:attendance_app/src/models/student_profile_model.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/profile_pic.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
        Text(studentData.fullName),
        Text(_profileViewModel.userId ?? ''),
        Text(
            'Department: ${studentData.department} Semester: ${studentData.semester}'),
        Text('Roll No.: ${studentData.rollNo}'),
        const Text('Student'),
        QrImage(
          data: _profileViewModel.userId ?? '',
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
