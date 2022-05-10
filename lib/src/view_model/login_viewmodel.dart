import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/sessions/user_session.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  //Login
  final emailLoginTextFieldController = TextEditingController();
  final passwordLogindTextFieldController = TextEditingController();

  //Register
  final emailRegisterTextFieldController = TextEditingController();
  final fullNameRegisterTextFieldController = TextEditingController();
  final departmentRegisterTextFieldController = TextEditingController();
  final semesterRegisterTextFieldController = TextEditingController();
  final rollNoTextFieldController = TextEditingController();
  final passwordRegisterTextFieldController = TextEditingController();
  final confirmPasswordRegisterTextFieldController = TextEditingController();

  LoginUserType _currentLoginUserType = LoginUserType.student;
  LoginUserType get currentLoginUserType => _currentLoginUserType;
  void setCurrentLoginUserType(LoginUserType userType) {
    _currentLoginUserType = userType;
    notifyListeners();
  }

  RegisterUserType _currentRegisterUserType = RegisterUserType.student;
  RegisterUserType get currentRegisterUserType => _currentRegisterUserType;
  void setCurrentRegisterUserType(RegisterUserType userType) {
    _currentRegisterUserType = userType;
    notifyListeners();
  }

  CollectionReference<Map<String, dynamic>> getDbCollection({
    required LoginUserType userType,
  }) {
    String _user = Utils.getLoginTypeFromEnum(userType);
    return _db.collection(_user);
  }

  Future<String?> get userId async =>
      await UserSession.getData(key: UserSession.userIdKey);

  Future<String?> get userType async =>
      await UserSession.getData(key: UserSession.userTypeKey);

  String _loginMessage = '';
  String get loginMessage => _loginMessage;

  Future<bool> login({
    required String email,
    required String password,
    required LoginUserType userType,
  }) async {
    try {
      final _collection = getDbCollection(userType: userType);
      final _documents = (await _collection.get()).docs;
      bool _hasEmail = _documents.any(
        (element) {
          return element.id == email;
        },
      );
      if (_hasEmail) {
        final _document = _collection.doc(email);
        final _data = (await _document.get()).data();
        if (_data!['password'] == password) {
          await UserSession.saveData(
            key: UserSession.userIdKey,
            data: email,
          );
          await UserSession.saveData(
            key: UserSession.userTypeKey,
            data: Utils.getLoginTypeFromEnum(userType),
          );
          return true;
        } else {
          _loginMessage = 'Incorrect Password!!';
        }
      } else {
        _loginMessage = 'Incorrect Email!!';
      }
      return false;
    } catch (e) {
      print(e);
      _loginMessage = 'Login Error!!';
      return false;
    }
  }

  Future<bool> logout() async {
    await UserSession.removeData(key: UserSession.userIdKey);
    await UserSession.removeData(key: UserSession.userTypeKey);
    return true;
  }
}
