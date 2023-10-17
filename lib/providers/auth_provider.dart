import 'package:flutter/material.dart';

import '../main.dart';
import '../models/User.dart';
import '../services/auth/interfaces/IAuthManager.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
  }

  Future<bool> checkSession() async {
    final bool hasSession = await locator.get<IAuthManager>().checkSession();
    final User? user = await locator.get<IAuthManager>().getUser();
    setUser(user);

    return hasSession;
  }

  Future<void> signOut() async {
    locator.get<IAuthManager>().signOut();
    setUser(null);
  }
}
