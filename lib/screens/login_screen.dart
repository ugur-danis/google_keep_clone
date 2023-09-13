import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../widgets/outline_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isShowPassword = false;
  String _email = '';
  String _password = '';

  final TextEditingController _eMailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _eMailController.text = _email;
    _passwordController.text = _password;

    _eMailController.addListener(() {
      setState(() {
        _email = _eMailController.text;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }


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
                  Text(
                    'Google Hesabınızı kullanın',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
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
                  )
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
      onChanged: (bool? value) {
        setState(() {
          _isShowPassword = value ?? false;
        });
      },
      value: _isShowPassword,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text('Şifreyi göster'),
    );
  }

  TextButton _buildCreateAccountButton() {
    return TextButton(
      onPressed: () {},
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        foregroundColor: MaterialStatePropertyAll(Colors.blue),
      ),
      child: const Text('Hesap oluşturun'),
    );
  }

  FilledButton _buildLoginButton() {
    return FilledButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
      child: const Text('Giriş yap'),
    );
  }
}
