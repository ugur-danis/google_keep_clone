// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../../main.dart';
import '../../services/archive/FirebaseArchiveDal.dart';
import '../../services/archive/FirebaseArchiveManager.dart';
import '../../services/archive/interfaces/IFirebaseArchiveDal.dart';
import '../../services/archive/interfaces/IFirebaseArchiveManager.dart';
import '../../services/auth/AuthManager.dart';
import '../../services/auth/FirebaseAuthDal.dart';
import '../../services/auth/interfaces/IAuthManager.dart';
import '../../services/auth/interfaces/IFirebaseAuthDal.dart';
import '../../services/firebase_storage/FirebaseStorageDal.dart';
import '../../services/firebase_storage/FirebaseStorageManager.dart';
import '../../services/firebase_storage/interfaces/IFirebaseStorageDal.dart';
import '../../services/firebase_storage/interfaces/IFirebaseStorageManager.dart';
import '../../services/note/FirebaseNoteDal.dart';
import '../../services/note/FirebaseNoteManager.dart';
import '../../services/note/interfaces/IFirebaseNoteDal.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../services/trash/FirebaseTrashDal.dart';
import '../../services/trash/FirebaseTrashManager.dart';
import '../../services/trash/interfaces/IFirebaseTrashDal.dart';
import '../../services/trash/interfaces/IFirebaseTrashManager.dart';
import '../../services/user/FirebaseUserDal.dart';
import '../../services/user/UserManager.dart';
import '../../services/user/interfaces/IFirebaseUserDal.dart';
import '../../services/user/interfaces/IUserManager.dart';
import 'IConfigureDependencies.dart';

class FirebaseConfigureDependencies implements IConfigureDependencies {
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final IFirebaseAuthDal authDal = FirebaseAuthDal();
    final IFirebaseUserDal userDal = FirebaseUserDal();
    final IFirebaseNoteDal noteDal = FirebaseNoteDal();
    final IFirebaseArchiveDal archiveDal = FirebaseArchiveDal();
    final IFirebaseTrashDal trashDal = FirebaseTrashDal();
    final IFirebaseStorageDal firebaseStorageDal = FirebaseStorageDal();

    final IAuthManager authManager = AuthManager(authDal: authDal);
    final IFirebaseStorageManager firebaseStorageManager =
        FirebaseStorageManager(storageDal: firebaseStorageDal);
    final IUserManager userManager = UserManager(
      userDal: userDal,
      firebaseStorageManager: firebaseStorageManager,
    );
    final IFirebaseNoteManager noteManager = FirebaseNoteManager(
      noteDal: noteDal,
      userDal: userDal,
      trashDal: trashDal,
      archiveDal: archiveDal,
    );
    final IFirebaseArchiveManager archiveManager = FirebaseArchiveManager(
      archiveDal: archiveDal,
      userDal: userDal,
      noteDal: noteDal,
      trashDal: trashDal,
    );

    final IFirebaseTrashManager trashManager = FirebaseTrashManager(
      noteDal: noteDal,
      userDal: userDal,
      trashDal: trashDal,
    );

    locator.registerLazySingleton<IAuthManager>(() => authManager);
    locator.registerLazySingleton<IUserManager>(() => userManager);
    locator.registerLazySingleton<IFirebaseNoteManager>(() => noteManager);
    locator
        .registerLazySingleton<IFirebaseArchiveManager>(() => archiveManager);
    locator.registerLazySingleton<IFirebaseTrashManager>(() => trashManager);
  }
}
