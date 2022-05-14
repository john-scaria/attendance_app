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
  final rollNoTextFieldController = TextEditingController();
  final passwordRegisterTextFieldController = TextEditingController();
  final confirmPasswordRegisterTextFieldController = TextEditingController();

  void clearRegistrationText() {
    emailRegisterTextFieldController.clear();
    fullNameRegisterTextFieldController.clear();
    rollNoTextFieldController.clear();
    passwordRegisterTextFieldController.clear();
    confirmPasswordRegisterTextFieldController.clear();
    _clearDropDowns();
  }

  void clearLoginText() {
    emailLoginTextFieldController.clear();
    passwordLogindTextFieldController.clear();
  }

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
          clearLoginText();
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

  CollectionReference<Map<String, dynamic>> getRegisterDbCollection({
    required RegisterUserType userType,
  }) {
    String _user = Utils.getRegisterTypeFromEnum(userType);
    return _db.collection(_user);
  }

  String _registerMessage = '';
  String get registerMessage => _registerMessage;

  Future<bool> register() async {
    try {
      final _collection =
          getRegisterDbCollection(userType: _currentRegisterUserType);
      final _documents = (await _collection.get()).docs;
      bool _hasEmail = _documents.any(
        (element) {
          return element.id == emailRegisterTextFieldController.text;
        },
      );
      if (_hasEmail) {
        _registerMessage = 'Email Already Exists. Try Another...';
        return false;
      }
      if (_currentRegisterUserType == RegisterUserType.student) {
        await _collection.doc(emailRegisterTextFieldController.text).set({
          'department': _selectedDepartment,
          'full_name': fullNameRegisterTextFieldController.text,
          'password': passwordRegisterTextFieldController.text,
          'roll_no': int.parse(rollNoTextFieldController.text),
          'semester': _selectedSemester,
        });
        _registerMessage = 'Registration Successful';
        clearRegistrationText();
        return true;
      }
      if (_currentRegisterUserType == RegisterUserType.staff) {
        await _collection.doc(emailRegisterTextFieldController.text).set({
          'full_name': fullNameRegisterTextFieldController.text,
          'password': passwordRegisterTextFieldController.text,
          'type': _selectedProfession,
        });
        _registerMessage = 'Registration Successful';
        clearRegistrationText();
        return true;
      }
      _registerMessage = 'Registration Failed';
      return false;
    } catch (e) {
      print(e);
      _registerMessage = 'Registration Failed';
      return false;
    }
  }

  final List<String> semesterList = [
    'S1',
    'S2',
    'S3',
  ];
  String _selectedSemester = 'S1';
  String get selectedSemester => _selectedSemester;
  void setSelectedSemester(String sem) {
    _selectedSemester = sem;
    notifyListeners();
  }

  final List<String> departmentList = [
    'CSE',
    'ME',
    'ECE',
    'EEE',
    'CE',
    'IT',
  ];
  String _selectedDepartment = 'CSE';
  String get selectedDepartment => _selectedDepartment;
  void setSelectedDepartment(String dept) {
    _selectedDepartment = dept;
    notifyListeners();
  }

  final List<String> professionList = [
    'Assistant Professor',
    'Professor',
    'Principal',
  ];
  String _selectedProfession = 'Assistant Professor';
  String get selectedProfession => _selectedProfession;
  void setSelectedProfession(String prof) {
    _selectedProfession = prof;
    notifyListeners();
  }

  void _clearDropDowns() {
    _selectedSemester = 'S1';
    _selectedDepartment = 'CSE';
    _selectedProfession = 'Assistant Professor';
  }
}
