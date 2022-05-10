import 'package:attendance_app/src/models/admin_profile_model.dart';
import 'package:attendance_app/src/models/scan_model.dart';
import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/qr_scanner_screen.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/profile_pic.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/src/ui/dialogs/proceed_dialog.dart'
    as proceed_dialog;
import 'package:provider/provider.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key, required this.adminProfileModel})
      : super(key: key);
  final AdminProfileModel adminProfileModel;

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = context.read<ProfileViewModel>();
    return Column(
      children: [
        const ProfilePic(),
        Text(adminProfileModel.fullName),
        Text(_profileViewModel.userId ?? ''),
        AppButton(
          onTap: () => _scanQr2(context),
          buttonText: 'Scan Qr Code',
        ),
      ],
    );
  }

  Future<void> _scanQr2(BuildContext context) async {
    final _scanData =
        context.read<ProfileViewModel>().getScanData('jane@abc.com#staff');
    print(_scanData.userId);
    print(_scanData.userType);
    /*  await Utils.dialogLoaderForBoolFuture(
      context,
      context.read<ProfileViewModel>().adminUploadScanData(
            dateTime: DateTime.now(),
            id: 'jane@abc.com',
            writeDataUserType: LoginUserType.staff,
          ),
    ).whenComplete(
      () {
        Utils.showSnackBar(
          context: context,
          message: context.read<ProfileViewModel>().scanMessage,
        );
      },
    ); */
  }

  Future<void> _scanQr(BuildContext context) async {
    final String? _qrCode = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QrScannerScreen(),
      ),
    );
    if (_qrCode != null) {
      print(
          '**************************** QR $_qrCode *******************************');
      final bool _isProceed =
          await proceed_dialog.proceedDialog(context) ?? false;
      if (_isProceed) {
        print(
            '**************************** Proceed $_isProceed *******************************');
      }
    }
  }
}
