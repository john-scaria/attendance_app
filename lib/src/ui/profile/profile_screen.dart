import 'package:attendance_app/src/fcm/fcm_notification_handler.dart';
import 'package:attendance_app/src/models/admin_profile_model.dart';
import 'package:attendance_app/src/models/screen_status.dart';
import 'package:attendance_app/src/models/staff_profile_model.dart';
import 'package:attendance_app/src/models/student_profile_model.dart';
import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/login_screen.dart';
import 'package:attendance_app/src/ui/profile/admin_profile.dart';
import 'package:attendance_app/src/ui/profile/staff_profile.dart';
import 'package:attendance_app/src/ui/profile/student_profile.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/src/ui/dialogs/leave_dialog.dart'
    as leave_dialog;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().getProfileData();
    FirebaseNotificationHandler().setupFirebase(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: setProfile(context.watch<ProfileViewModel>().profileScreenStatus),
    );
  }

  Widget setProfile(ScreenStatus status) {
    switch (status) {
      case ScreenStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ScreenStatus.error:
        return const Center(
          child: Text('No Data Available'),
        );
      case ScreenStatus.success:
        return const ProfileBody();
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = context.read<ProfileViewModel>();
    final _userData = _profileViewModel.userData;
    return SingleChildScrollView(
      child: Column(
        children: [
          setType(
            userType: _profileViewModel.userType,
            userData: _userData,
          ),
          if (_profileViewModel.userType != LoginUserType.admin)
            Column(
              children: [
                Constants.verticalSpacer10,
                AppButton(
                  onTap: () => _applyLeave(context),
                  buttonText: 'Apply Leave',
                ),
              ],
            ),
          Constants.verticalSpacer15,
          AppButton(
            buttonColor: Colors.white,
            borderSideColor: Colors.black,
            textColor: Colors.black,
            onTap: () => _logout(context),
            buttonText: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget setType(
      {required LoginUserType? userType, required dynamic userData}) {
    switch (userType) {
      case LoginUserType.student:
        return StudentProfile(
          studentData: userData as StudentProfileModel,
        );
      case LoginUserType.staff:
        return StaffProfile(
          staffProfileModel: userData as StaffProfileModel,
        );
      case LoginUserType.admin:
        return AdminProfile(
          adminProfileModel: userData as AdminProfileModel,
        );
      default:
        return const Center(
          child: Text('No Data Available'),
        );
    }
  }

  Future<void> _logout(BuildContext context) async {
    Utils.dialogLoaderForBoolFuture(
      context,
      context.read<LoginViewModel>().logout(),
    ).whenComplete(
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }

  Future<void> _applyLeave(BuildContext context) async {
    final _leaveData = await leave_dialog.leaveDialog(context);
    if (_leaveData != null) {
      final _isLeaveApplied = await Utils.dialogLoaderForBoolFuture(
        context,
        context.read<ProfileViewModel>().applyLeave(
              date: _leaveData.date,
              reason: _leaveData.reason,
            ),
      );
      if (_isLeaveApplied) {
        context.read<ProfileViewModel>().clearLeaveRecords();
        Utils.showSnackBar(
          context: context,
          message: 'Leave Applied',
        );
      } else {
        Utils.showSnackBar(
          context: context,
          message: 'Unable to apply Leave!!',
        );
      }
    }
  }
}
