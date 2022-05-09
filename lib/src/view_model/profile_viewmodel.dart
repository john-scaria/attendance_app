import 'package:attendance_app/src/models/admin_profile_model.dart';
import 'package:attendance_app/src/models/screen_status.dart';
import 'package:attendance_app/src/models/staff_profile_model.dart';
import 'package:attendance_app/src/models/student_profile_model.dart';
import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final leaveReasonTextFieldController = TextEditingController();

  LoginUserType? _userType;
  LoginUserType? get userType => _userType;
  void setUserType(LoginUserType userType) {
    _userType = userType;
  }

  String? _userId;
  String? get userId => _userId;
  void setUserId(String userId) {
    _userId = userId;
  }

  CollectionReference<Map<String, dynamic>> getDbCollection({
    required LoginUserType userType,
  }) {
    String _user = Utils.getLoginTypeFromEnum(userType);
    return _db.collection(_user);
  }

  dynamic _userData;
  dynamic get userData => _userData;

  ScreenStatus _profileScreenStatus = ScreenStatus.loading;
  ScreenStatus get profileScreenStatus => _profileScreenStatus;

  void setProfileScreenStatus(ScreenStatus status) {
    _profileScreenStatus = status;
    notifyListeners();
  }

  Future<void> getProfileData() async {
    try {
      await Future.delayed(Duration.zero);
      setProfileScreenStatus(ScreenStatus.loading);
      final _collection =
          getDbCollection(userType: _userType ?? LoginUserType.student);
      final _data = (await _collection.doc(_userId).get()).data() ?? {};
      switch (_userType) {
        case LoginUserType.student:
          _userData = StudentProfileModel.fromMap(_data);
          break;
        case LoginUserType.staff:
          _userData = StaffProfileModel.fromMap(_data);
          break;
        case LoginUserType.admin:
          _userData = AdminProfileModel.fromMap(_data);
          break;
        default:
          _userData = null;
      }
      print(_data);
      if (_userData != null) {
        setProfileScreenStatus(ScreenStatus.success);
      } else {
        setProfileScreenStatus(ScreenStatus.error);
      }
    } catch (e) {
      print(e);
      setProfileScreenStatus(ScreenStatus.error);
    }
  }
}
