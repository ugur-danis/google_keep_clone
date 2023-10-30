// ignore_for_file: file_names

import 'dart:io';

abstract class IFirebaseStorageManager {
  Future<String?> uploadFile(String path, File file);
}
