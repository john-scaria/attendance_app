import 'package:attendance_app/src/models/user_type.dart';
import 'package:attendance_app/src/ui/register_screen.dart';
import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:attendance_app/src/ui/widgets/app_tabs.dart';
import 'package:attendance_app/src/ui/widgets/app_textfield.dart';
import 'package:attendance_app/src/ui/widgets/tab_widget.dart';
import 'package:attendance_app/src/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = context.read<LoginViewModel>();
    return AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTabs(
            tabWidget: LoginUserType.values
                .map(
                  (e) => TabWidget(
                    onTabTap: () => _loginViewModel.setCurrentLoginUserType(e),
                    tabColor: e ==
                            context.watch<LoginViewModel>().currentLoginUserType
                        ? Colors.grey
                        : Colors.red,
                    tabName: e.name.toUpperCase(),
                  ),
                )
                .toList(),
          ),
          AppTextField(
            textEditingController:
                _loginViewModel.emailLoginTextFieldController,
            hintText: 'Email',
          ),
          AppTextField(
            textEditingController:
                _loginViewModel.passwordLogindTextFieldController,
            hintText: 'Password',
          ),
          AppButton(
            onTap: () => _login(
              context,
              _loginViewModel.emailLoginTextFieldController.text,
              _loginViewModel.passwordLogindTextFieldController.text,
            ),
            buttonText: 'Login',
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RegisterScreen(),
              ),
            ),
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  Future<void> _login(
    BuildContext context,
    String emailAddress,
    String password,
  ) async {
    bool _isLoginSuccess = await context.read<LoginViewModel>().login(
          email: emailAddress,
          password: password,
          userType: context.read<LoginViewModel>().currentLoginUserType,
        );
    if (_isLoginSuccess) {
      Phoenix.rebirth(context);
    }
  }
}
