import 'package:attendance_app/src/ui/splash_screen.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:attendance_app/src/view_model/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (_) => ProfileViewModel(),
        ),
      ],
      child: const MyMaterial(),
    );
  }
}

class MyMaterial extends StatelessWidget {
  const MyMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
