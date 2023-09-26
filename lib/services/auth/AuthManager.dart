// ignore_for_file: file_names

import '../../models/User.dart';
import 'interfaces/IAuthDal.dart';
import 'interfaces/IAuthManager.dart';

class AuthManager implements IAuthManager {
  AuthManager({required IAuthDal authDal}) : _authDal = authDal;

  final IAuthDal _authDal;

  @override
  Future<bool> checkSession() async {
    return await _authDal.checkSession();
  }

  @override
  Future<User?> getUser() async {
    return await _authDal.getUser();
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _authDal.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<User?> signInWithGoogle() async {
    return await _authDal.signInWithGoogle();
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    await _authDal.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _authDal.signOut();
  }
}
