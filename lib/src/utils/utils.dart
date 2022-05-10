import 'package:attendance_app/src/models/user_type.dart';
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
}
