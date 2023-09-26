part of 'sign_up_screen.dart';

mixin _SignUpScreenMixin on State<SignUpScreen> {
  late final IAuthManager _authManager;
  final TextEditingController _eMailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isShowPassword = false;

  @override
  void dispose() {
    super.dispose();

    _eMailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _authManager = locator<IAuthManager>();
  }

  void _signUpWithEmail() async {
    try {
      await _authManager.signUp(
          email: _eMailController.text, password: _passwordController.text);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));
    } catch (e) {
      throw Exception('Sign up error!');
    }
  }

  void _navToSignInScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  void _onTogglePasswordVisibility(bool? value) {
    setState(() {
      _isShowPassword = value ?? false;
    });
  }
}
