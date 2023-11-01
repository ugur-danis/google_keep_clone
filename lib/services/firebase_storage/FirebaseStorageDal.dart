// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'interfaces/IFirebaseStorageDal.dart';

class FirebaseStorageDal implements IFirebaseStorageDal {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String?> uploadFile(String path, File file) async {
    try {
      TaskSnapshot snapshot = await _firebaseStorage.ref(path).putFile(file);
      return snapshot.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
