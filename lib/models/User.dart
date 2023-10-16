// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

import '../services/interfaces/IEntity.dart';

class User extends IEntity {
  User({
    this.id,
    this.username,
    this.email,
    this.photoURL,
    this.refreshToken,
  });

  final String? id;
  final String? username;
  final String? email;
  final String? photoURL;
  final String? refreshToken;

  User.fromFirebaseUser(FirebaseAuth.User? user)
      : id = user?.uid,
        username = user?.displayName,
        email = user?.email,
        photoURL = user?.photoURL,
        refreshToken = user?.refreshToken;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
        'photoURL': photoURL,
        'refreshToken': refreshToken,
      };
}
