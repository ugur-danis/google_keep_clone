// ignore_for_file: file_names

import '../../../models/User.dart';

abstract class IUserDal {
  Future<User?> getUser();
