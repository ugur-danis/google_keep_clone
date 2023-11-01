// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../services/interfaces/IEntity.dart';

class User extends IEntity<User> {
  User({
    this.id,
    this.username,
    this.email,
    this.photo,
    this.refreshToken,
  });

  @override
  // ignore: overridden_fields
  String? id;
  String? username;
  String? email;
  String? photo;
  String? refreshToken;

  User.fromFirebaseUser(firebase_auth.User? user)
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

  @override
  User fromMap(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      email: data['email'],
      photo: data['photo'],
      refreshToken: data['refreshToken'],
    );
  }
}
