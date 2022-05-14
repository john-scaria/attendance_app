import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/register_screen.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:attendance_app/src/ui/widgets/app_tabs.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/ui/widgets/logo_widget.dart';
import 'package:attendance_app/src/ui/widgets/tab_widget.dart';
import 'package:attendance_app/src/utils/constants.dart';
import 'package:attendance_app/src/utils/utils.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = context.read<LoginViewModel>();
    return AppScaffold(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              const LogoWidget(
                size: Size(150, 150),
              ),
              Constants.verticalSpacer20,
              AppTabs(
                tabWidget: LoginUserType.values
                    .map(
                      (e) => TabWidget(
                        onTabTap: () =>
                            _loginViewModel.setCurrentLoginUserType(e),
                        tabColor: e ==
                                context
                                    .watch<LoginViewModel>()
                                    .currentLoginUserType
                            ? Constants.brownColor
                            : Colors.transparent,
                        tabName: e.name.toUpperCase(),
                        textColor: e ==
                                context
                                    .watch<LoginViewModel>()
                                    .currentLoginUserType
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
                    _loginViewModel.emailLoginTextFieldController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be Empty';
                  }
                  return null;
                },
              ),
              Constants.verticalSpacer20,
              AppTextField(
                obscureText: true,
                textEditingController:
                    _loginViewModel.passwordLogindTextFieldController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be Empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              AppButton(
                horizontalPadding: 30.0,
                onTap: () => _login(
                  context,
                  _loginViewModel.emailLoginTextFieldController.text,
                  _loginViewModel.passwordLogindTextFieldController.text,
                ),
                buttonText: 'Login',
              ),
              const SizedBox(
                height: 5.0,
              ),
              InkWell(
                onTap: () {
                  _loginViewModel.clearRegistrationText();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'No Account? Register here.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(
    BuildContext context,
    String emailAddress,
    String password,
  ) async {
    if (_formKey.currentState!.validate()) {
      bool _isLoginSuccess = await Utils.dialogLoaderForBoolFuture(
        context,
        context.read<LoginViewModel>().login(
              email: emailAddress,
              password: password,
              userType: context.read<LoginViewModel>().currentLoginUserType,
            ),
      );
      if (_isLoginSuccess) {
        Phoenix.rebirth(context);
      } else {
        Utils.showSnackBar(
            context: context,
            message: context.read<LoginViewModel>().loginMessage);
      }
    }
  }
}
