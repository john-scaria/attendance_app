import 'package:attendance_app/src/models/admin_profile_model.dart';
import 'package:attendance_app/src/models/proceed_model.dart';
import 'package:attendance_app/src/ui/qr_scanner_screen.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/profile_pic.dart';
import 'package:attendance_app/src/utils/constants.dart';
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
        Constants.verticalSpacer5,
        Text(
          adminProfileModel.fullName,
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
        Constants.verticalSpacer15,
        AppButton(
          onTap: () => _proceedToCollectData(context),
          buttonText: 'Scan Qr Code',
        ),
      ],
    );
  }

  Future<void> _proceedToCollectData(BuildContext context) async {
    final _qrCode = await _scanQr(context);
    if (_qrCode != null) {
      final _scanData = context.read<ProfileViewModel>().getScanData(_qrCode);
      final ProceedModel? _proceedData =
          await Utils.dialogLoaderForDynamicFuture(
        context,
        context.read<ProfileViewModel>().getVerificationDataFromDatabase(
              uid: _scanData?.userId ?? '',
              type: Utils.getLoginTypeFromString(_scanData?.userType),
            ),
      );
      if (_proceedData != null) {
        final bool _isProceed = await proceed_dialog.proceedDialog(
              context,
              name: _proceedData.name,
              subText: _proceedData.subtitle,
            ) ??
            false;
        if (_isProceed) {
          await Utils.dialogLoaderForBoolFuture(
            context,
            context.read<ProfileViewModel>().adminUploadScanData(
                  dateTime: DateTime.now(),
                  id: _scanData?.userId ?? '',
                  writeDataUserType:
                      Utils.getLoginTypeFromString(_scanData?.userType),
                ),
          ).whenComplete(
            () {
              Utils.showSnackBar(
                context: context,
                message: context.read<ProfileViewModel>().scanMessage,
              );
            },
          );
        }
      } else {
        Utils.showSnackBar(
          context: context,
          message: 'Invalid Data!!!',
        );
      }
    }
  }

  Future<String?> _scanQr(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QrScannerScreen(),
      ),
    );
  }
}
