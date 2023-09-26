import 'package:flutter/material.dart';
import 'package:google_keep_clone/main.dart';
import 'package:google_keep_clone/services/auth/interfaces/IAuthManager.dart';

import '../models/User.dart';

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
}
