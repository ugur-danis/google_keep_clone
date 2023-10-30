// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

import '../services/interfaces/IEntity.dart';

class User extends IEntity {
  User({
    this.id,
    this.username,
    this.email,
    this.photo,
    this.refreshToken,
  });

  String? id;
  String? username;
  String? email;
  String? photo;
  String? refreshToken;

  User.fromFirebaseUser(FirebaseAuth.User? user)
      : id = user?.uid,
        username = user?.displayName,
        email = user?.email,
        photo = user?.photoURL,
        refreshToken = user?.refreshToken;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
        'photoURL': photo,
        'refreshToken': refreshToken,
      };
}
