import 'dart:async';

import 'package:attendance_app/src/ui/login_screen.dart';
import 'package:attendance_app/src/ui/profile/profile_screen.dart';
import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:attendance_app/src/ui/profile/profile_screen.dart';
import 'package:attendance_app/src/ui/widgets/logo_widget.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 2), onDoneLoading);
  }

  Future<void> onDoneLoading() async {
    final _loginViewModel = context.read<LoginViewModel>();
    final String? _userId = await _loginViewModel.userId;
    final String? _userType = await _loginViewModel.userType;
    if (_userId != null && _userType != null) {
      final _profileViewModel = context.read<ProfileViewModel>();
      _profileViewModel.setUserId(_userId);
      _profileViewModel.setUserType(Utils.getLoginTypeFromString(_userType));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      child: Center(child: LogoWidget()),
    );
  }
}
