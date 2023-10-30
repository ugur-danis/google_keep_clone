part of 'sign_in_screen.dart';

mixin _SignInScreenMixin on State<SignInScreen> {
  late final IAuthManager _authManager;
  late final UserProvider _userProvider;
  final TextEditingController _eMailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isShowPassword = false;

  @override
  void initState() {
    super.initState();
    _authManager = locator<IAuthManager>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userProvider = Provider.of<UserProvider>(context, listen: false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _eMailController.dispose();
    _passwordController.dispose();
  }

  void _signInWithGoogle() async {
    User? user = await _authManager.signInWithGoogle();
    if (user == null) return;

    _userProvider.setUser(user);
    _navToHomeScreen();
  }

  void _signInWithEmailAndPassword() async {
    User? user = await _authManager.signInWithEmailAndPassword(
      email: _eMailController.text,
      password: _passwordController.text,
    );
    if (user == null) return;

    _userProvider.setUser(user);
    _navToHomeScreen();
  }

  void _onTogglePasswordVisibility(bool? value) {
    setState(() {
      _isShowPassword = value ?? false;
    });
  }

  void _navToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _navToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
