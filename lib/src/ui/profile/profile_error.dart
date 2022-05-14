import 'package:attendance_app/src/ui/login_screen.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileError extends StatelessWidget {
  const ProfileError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No Data Available'),
        Constants.verticalSpacer15,
        AppButton(
          buttonColor: Colors.white,
          borderSideColor: Colors.black,
          textColor: Colors.black,
          onTap: () => _logout(context),
          buttonText: 'Logout',
        ),
      ],
    );
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
}
