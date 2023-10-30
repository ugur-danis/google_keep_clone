// ignore_for_file: file_names

import 'dart:io';

import '../../models/User.dart';
import '../firebase_storage/interfaces/IFirebaseStorageManager.dart';
import 'interfaces/IUserManager.dart';
import 'interfaces/IUserDal.dart';

class UserManager implements IUserManager {
  late final IUserDal _userDal;
  late final IFirebaseStorageManager _firebaseStorageManager;

  UserManager({
    required IUserDal userDal,
    required IFirebaseStorageManager firebaseStorageManager,
  })  : _userDal = userDal,
        _firebaseStorageManager = firebaseStorageManager;

  @override
  Future<User?> getUser() async {
    return await _userDal.getUser();
  }

  @override
  Future<String?> changeProfilePicture(File photo) async {
    final User? user = await getUser();
    if (user == null) return null;

    final String path = 'profile_images/${user.id}';

    String? photoUrl = await _firebaseStorageManager.uploadFile(path, photo);
    await _userDal.updatePhoto(photoUrl);

    return photoUrl;
  }
}
