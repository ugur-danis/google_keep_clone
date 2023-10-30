// ignore_for_file: file_names

import 'dart:io';

import '../../models/User.dart';
import 'interfaces/IUserManager.dart';
import 'interfaces/IUserDal.dart';

class UserManager implements IUserManager {
  late final IUserDal _userDal;

  UserManager({required IUserDal userDal}) : _userDal = userDal;

  @override
  Future<User?> getUser() async {
    return await _userDal.getUser();
  }
}
