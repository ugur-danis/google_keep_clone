part of 'sign_in_screen.dart';

mixin _SignInScreenMixin on State<SignInScreen> {
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

  void _signInWithGoogle() async {
    User? user = await _authManager.signInWithGoogle();
    if (user != null) {
      context.read<AuthProvider>().setUser(user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  void _signInWithEmailAndPassword() async {
    User? user = await _authManager.signInWithEmailAndPassword(
        email: _eMailController.text, password: _passwordController.text);

    if (user != null) {
      context.read<AuthProvider>().setUser(user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  void _navToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _onTogglePasswordVisibility(bool? value) {
    setState(() {
      _isShowPassword = value ?? false;
    });
  }
}
