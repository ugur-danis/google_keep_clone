library login_screen;

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../services/auth/interfaces/IAuthManager.dart';
import '../../widgets/outline_input.dart';
import '../sign_in/sign_in_screen.dart';

part 'sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with _SignUpScreenMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Hesap oluştur',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 40),
                  OutlineInput(
                    labelText: 'E-posta',
                    controller: _eMailController,
                  ),
                  const SizedBox(height: 20),
                  OutlineInput(
                    labelText: 'Şifrenizi girin',
                    obscureText: !_isShowPassword,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10),
                  _buildShowPasswordCheckbox(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildIHaveAccountButton(),
                      _buildLoginButton(),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CheckboxListTile _buildShowPasswordCheckbox() {
    return CheckboxListTile(
      onChanged: _onTogglePasswordVisibility,
      value: _isShowPassword,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text('Şifreyi göster'),
    );
  }

  TextButton _buildIHaveAccountButton() {
    return TextButton(
      onPressed: _navToSignInScreen,
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        foregroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: const Text('Zaten heabım var'),
    );
  }

  FilledButton _buildLoginButton() {
    return FilledButton(
      onPressed: _signUpWithEmail,
      child: const Text('Hesap oluştur'),
    );
  }
}
