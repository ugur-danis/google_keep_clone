// ignore_for_file: file_names

import 'dart:io';

import '../../../models/User.dart';

abstract class IUserManager {
  Future<User?> getUser();
