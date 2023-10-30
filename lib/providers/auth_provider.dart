import 'package:flutter/material.dart';

import '../main.dart';
import '../services/auth/interfaces/IAuthManager.dart';

class AuthProvider extends ChangeNotifier {
  final IAuthManager _authManager = locator<IAuthManager>();

  Future<bool> get hasSession async => _authManager.checkSession();
  Future<void> signOut() async => _authManager.signOut();
}
