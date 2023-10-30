import 'dart:io';

import 'package:flutter/foundation.dart';

import '../main.dart';
import '../models/User.dart';
import '../services/user/interfaces/IUserManager.dart';

class UserProvider extends ChangeNotifier {
  final IUserManager _userManager = locator<IUserManager>();
  User? _user;

  UserProvider() {
    _userManager.getUser().then((user) => setUser(user));
  }

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> changeProfilePhoto(File photo) async {
    final String? photoUrl = await _userManager.changeProfilePicture(photo);
    _user!.photo = photoUrl;
    notifyListeners();
  }
}
