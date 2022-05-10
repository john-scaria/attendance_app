import 'package:attendance_app/src/models/admin_profile_model.dart';
import 'package:attendance_app/src/models/proceed_model.dart';
import 'package:attendance_app/src/models/scan_model.dart';
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

  ScanModel? getScanData(String scanData) {
    if (scanData.contains('<##>')) {
      final _splits = scanData.split(RegExp(r'<##>'));
      return ScanModel(_splits[0], _splits[1]);
    }
    return null;
  }

  Future<ProceedModel?> getVerificationDataFromDatabase({
    required String uid,
    required LoginUserType type,
  }) async {
    try {
      final _collection = getDbCollection(userType: type);
      final _data = (await _collection.doc(uid).get()).data();
      if (type == LoginUserType.student) {
        return ProceedModel(
          'Name: ${_data!['full_name']}',
          'Department: ${_data['department']} Semester: ${_data['semester']}',
        );
      } else if (type == LoginUserType.staff) {
        return ProceedModel(
          'Name: ${_data!['full_name']}',
          'Type: ${_data['type']}',
        );
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _scanMessage = '';
  String get scanMessage => _scanMessage;

  Future<bool> adminUploadScanData({
    required DateTime dateTime,
    required LoginUserType writeDataUserType,
    required String id,
  }) async {
    try {
      final _collection = getDbCollection(userType: writeDataUserType)
          .doc(id)
          .collection('attendance');
      final _documents = (await _collection.get()).docs;
      bool _hasDate = _documents.any(
        (element) {
          return element.id == Utils.timeToddMMyyyyString(dateTime);
        },
      );
      if (!_hasDate) {
        await _collection.doc(Utils.timeToddMMyyyyString(dateTime)).set(
          {
            "time": dateTime.toString(),
            "status": true,
          },
        );
        _scanMessage = 'Attendance Updated!!';
        notifyListeners();
        return true;
      }
      _scanMessage = 'Attendance Already Marked!!';
      notifyListeners();
      return false;
    } catch (e) {
      print(e);
      _scanMessage = 'Unable to Update Attendance!!';
      notifyListeners();
      return false;
    }
  }
}
