import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getLoginTypeFromEnum(LoginUserType? userType) {
    switch (userType) {
      case LoginUserType.admin:
        return 'admin';
      case LoginUserType.student:
        return 'students';
      case LoginUserType.staff:
        return 'staff';
      default:
        return 'students';
    }
  }

  static LoginUserType getLoginTypeFromString(String? userType) {
    switch (userType) {
      case 'admin':
        return LoginUserType.admin;
      case 'students':
        return LoginUserType.student;
      case 'staff':
        return LoginUserType.staff;
      default:
        return LoginUserType.student;
    }
  }

  static String getRegisterTypeFromEnum(RegisterUserType? userType) {
    switch (userType) {
      case RegisterUserType.student:
        return 'students';
      case RegisterUserType.staff:
        return 'staff';
      default:
        return 'students';
    }
  }

  static RegisterUserType? getRegisterTypeFromString(String? userType) {
    switch (userType) {
      case 'students':
        return RegisterUserType.student;
      case 'staff':
        return RegisterUserType.staff;
      default:
        return null;
    }
  }

  static String timeToddMMyyyyString(DateTime? time) {
    return time != null
        ? DateFormat('dd-MM-yyyy').format(time)
        : 'Time not Specified';
  }

  static Future<bool> dialogLoaderForBoolFuture(
    BuildContext cx,
    Future<bool>? future,
  ) async {
    return await showDialog(
      context: cx,
      barrierDismissible: false,
      builder: (ctx) {
        future?.then(
          (value) => Navigator.pop(ctx, value),
        );
        return commonAlertDialog(loaderWidget());
      },
    );
  }

  static Future dialogLoaderForDynamicFuture(
    BuildContext cx,
    Future? future,
  ) async {
    return await showDialog(
      context: cx,
      barrierDismissible: false,
      builder: (ctx) {
        future?.then(
          (value) => Navigator.pop(ctx, value),
        );
        return commonAlertDialog(loaderWidget());
      },
    );
  }

  static Widget loaderWidget() => Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Please Wait.."),
          ),
        ],
      );

  static AlertDialog commonAlertDialog(Widget child) => AlertDialog(
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: child,
      );

  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(
          seconds: 1,
        ),
      ),
    );
  }

  static String setQrCode(String? uid, String? type) {
    if (uid != null && type != null) {
      return '$uid<##>$type';
    }
    return 'abc';
  }

  static Future<bool> yesNoDialog(
    context, {
    String? title,
    String? message,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (ctx) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              scrollable: true,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Constants.verticalSpacer15,
                  Text(message ?? ''),
                  Constants.verticalSpacer15,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          buttonColor: Colors.white,
                          borderSideColor: Colors.black,
                          textColor: Colors.black,
                          buttonText: 'NO',
                          onTap: () => Navigator.pop(context, false),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: AppButton(
                          buttonText: 'YES',
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
          },
        ) ??
        false;
  }
}
