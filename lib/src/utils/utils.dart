import 'package:attendance_app/src/models/user_type.dart';

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
}
