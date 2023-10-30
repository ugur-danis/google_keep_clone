// ignore_for_file: file_names

import 'dart:io';

import 'interfaces/IFirebaseStorageDal.dart';
import 'interfaces/IFirebaseStorageManager.dart';

class FirebaseStorageManager implements IFirebaseStorageManager {
  late final IFirebaseStorageDal _firebaseStorageDal;

  FirebaseStorageManager({required IFirebaseStorageDal storageDal})
      : _firebaseStorageDal = storageDal;

  @override
  Future<String?> uploadFile(String path, File file) async {
    return _firebaseStorageDal.uploadFile(path, file);
  }
}
