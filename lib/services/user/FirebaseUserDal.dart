// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../models/User.dart';
import 'interfaces/IFirebaseUserDal.dart';

class FirebaseUserDal implements IFirebaseUserDal {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  @override
  Future<User?> getUser() async {
    return User.fromFirebaseUser(_firebaseAuth.currentUser);
  }

  @override
  Future<void> updatePhoto(String? photoUrl) async {
    try {
      await _firebaseAuth.currentUser!.updatePhotoURL(photoUrl);
    } catch (e) {
      rethrow;
    }
  }
}
