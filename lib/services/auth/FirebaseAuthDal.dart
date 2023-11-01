// ignore_for_file: file_names

// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/User.dart';
import 'interfaces/IFirebaseAuthDal.dart';

class FirebaseAuthDal implements IFirebaseAuthDal {
  final FirebaseAuth.FirebaseAuth _firebaseAuth =
      FirebaseAuth.FirebaseAuth.instance;

  @override
  Future<bool> checkSession() {
    return Future.value(_firebaseAuth.currentUser == null ? false : true);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      FirebaseAuth.UserCredential userCredential = await FirebaseAuth
          .FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return User.fromFirebaseUser(userCredential.user);
    } on FirebaseAuth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      }
    }
    return null;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = FirebaseAuth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseAuth.UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    return User.fromFirebaseUser(userCredential.user);
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
