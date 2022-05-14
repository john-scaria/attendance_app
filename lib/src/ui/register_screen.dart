import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_dropdown.dart';
import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:attendance_app/src/ui/widgets/app_tabs.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/ui/widgets/tab_widget.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = context.read<LoginViewModel>();
    return AppScaffold(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                            ? Constants.brownColor
                            : Colors.transparent,
                        tabName: e.name.toUpperCase(),
                        textColor: e ==
                                context
                                    .watch<LoginViewModel>()
                                    .currentRegisterUserType
                            ? Colors.white
                            : Colors.black,
                      ),
                    )
                    .toList(),
              ),
              Constants.verticalSpacer20,
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                textEditingController:
                    _loginViewModel.emailRegisterTextFieldController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be Empty';
                  }
                  return null;
                },
              ),
              Constants.verticalSpacer15,
              AppTextField(
                textEditingController:
                    _loginViewModel.fullNameRegisterTextFieldController,
                hintText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full Name cannot be Empty';
                  }
                  return null;
                },
              ),
              Constants.verticalSpacer15,
              context.watch<LoginViewModel>().currentRegisterUserType ==
                      RegisterUserType.student
                  ? Column(
                      children: [
                        AppDropDown<String>(
                          onChanged: (value) => _loginViewModel
                              .setSelectedDepartment(value ?? 'CSE'),
                          value: context
                              .watch<LoginViewModel>()
                              .selectedDepartment,
                          items: _loginViewModel.departmentList
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                        Constants.verticalSpacer15,
                        AppDropDown<String>(
                          onChanged: (value) => _loginViewModel
                              .setSelectedSemester(value ?? 'S1'),
                          value:
                              context.watch<LoginViewModel>().selectedSemester,
                          items: _loginViewModel.semesterList
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                        Constants.verticalSpacer15,
                        AppTextField(
                          keyboardType: TextInputType.number,
                          textEditingController:
                              _loginViewModel.rollNoTextFieldController,
                          hintText: 'Roll No.',
                          validator: (value) {
                            if (context
                                    .read<LoginViewModel>()
                                    .currentRegisterUserType !=
                                RegisterUserType.student) {
                              return null;
                            } else {
                              if (value == null || value.isEmpty) {
                                return 'Roll No cannot be Empty';
                              }
                              return null;
                            }
                          },
                        ),
                      ],
                    )
                  : AppDropDown<String>(
                      onChanged: (value) =>
                          _loginViewModel.setSelectedProfession(
                              value ?? 'Assistant Professor'),
                      value: context.watch<LoginViewModel>().selectedProfession,
                      items: _loginViewModel.professionList
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                    ),
              Constants.verticalSpacer15,
              AppTextField(
                obscureText: true,
                textEditingController:
                    _loginViewModel.passwordRegisterTextFieldController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be Empty';
                  }
                  return null;
                },
              ),
              Constants.verticalSpacer15,
              AppTextField(
                obscureText: true,
                textEditingController:
                    _loginViewModel.confirmPasswordRegisterTextFieldController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password cannot be Empty';
                  }
                  if (_loginViewModel
                          .passwordRegisterTextFieldController.text !=
                      value) {
                    return 'Passwords not matching..';
                  }
                  return null;
                },
              ),
              Constants.verticalSpacer15,
              AppButton(
                horizontalPadding: 30.0,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    bool _isRegistered = await Utils.dialogLoaderForBoolFuture(
                      context,
                      _loginViewModel.register(),
                    );
                    if (_isRegistered) {
                      _loginViewModel.clearLoginText();
                      Navigator.pop(context);
                      Utils.showSnackBar(
                        context: context,
                        message: _loginViewModel.registerMessage,
                      );
                    } else {
                      Utils.showSnackBar(
                        context: context,
                        message: _loginViewModel.registerMessage,
                      );
                    }
                  }
                },
                buttonText: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
