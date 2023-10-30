// ignore_for_file: file_names

import '../../../models/User.dart';

abstract class IAuthRepository {
  Future<bool> checkSession();
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<User?> signInWithGoogle();
  Future<void> signUp({required String email, required String password});
  Future<void> signOut();
}
