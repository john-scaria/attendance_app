import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:attendance_app/src/ui/widgets/app_tabs.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/ui/widgets/tab_widget.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = context.read<LoginViewModel>();
    return AppScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppTabs(
              tabWidget: RegisterUserType.values
                  .map(
                    (e) => TabWidget(
                      onTabTap: () =>
                          _loginViewModel.setCurrentRegisterUserType(e),
                      tabColor: e ==
                              context
                                  .watch<LoginViewModel>()
                                  .currentRegisterUserType
                          ? Colors.grey
                          : Colors.red,
                      tabName: e.name.toUpperCase(),
                    ),
                  )
                  .toList(),
            ),
            AppTextField(
              textEditingController:
                  _loginViewModel.emailRegisterTextFieldController,
              hintText: 'Email',
            ),
            AppTextField(
              textEditingController:
                  _loginViewModel.fullNameRegisterTextFieldController,
              hintText: 'Full Name',
            ),
            AppTextField(
              textEditingController:
                  _loginViewModel.departmentRegisterTextFieldController,
              hintText: 'Department',
            ),
            AppTextField(
              textEditingController:
                  _loginViewModel.semesterRegisterTextFieldController,
              hintText: 'Semester',
            ),
            AppTextField(
              textEditingController: _loginViewModel.rollNoTextFieldController,
              hintText: 'Roll No.',
            ),
            AppTextField(
              textEditingController:
                  _loginViewModel.passwordRegisterTextFieldController,
              hintText: 'Password',
            ),
            AppTextField(
              textEditingController:
                  _loginViewModel.confirmPasswordRegisterTextFieldController,
              hintText: 'Confirm Password',
            ),
            AppButton(
              onTap: () {},
              buttonText: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
