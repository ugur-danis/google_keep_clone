library login_screen;

import 'package:flutter/material.dart';
import 'package:google_keep_clone/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/User.dart';
import '../../services/auth/interfaces/IAuthManager.dart';
import '../../widgets/outline_input.dart';
import '../home_screen.dart';
import '../sign_up/sign_up_screen.dart';

part 'sign_in_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with _SignInScreenMixin {
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
                    'Oturum aç',
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
                      _buildCreateAccountButton(),
                      _buildLoginButton(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSignInWithGoogleButton(),
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

  TextButton _buildCreateAccountButton() {
    return TextButton(
      onPressed: _navToSignUpScreen,
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        foregroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: const Text('Hesap oluşturun'),
    );
  }

  TextButton _buildSignInWithGoogleButton() {
    return TextButton(
      onPressed: _signInWithGoogle,
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: const Text('Google ile giriş yap'),
    );
  }

  FilledButton _buildLoginButton() {
    return FilledButton(
      onPressed: _signInWithEmailAndPassword,
      child: const Text('Giriş yap'),
    );
  }
}
