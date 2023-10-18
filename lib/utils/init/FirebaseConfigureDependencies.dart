// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart';
import 'package:google_keep_clone/services/archive/FirebaseArchiveDal.dart';
import 'package:google_keep_clone/services/archive/FirebaseArchiveManager.dart';
import 'package:google_keep_clone/services/archive/interfaces/IFirebaseArchiveManager.dart';

import '../../firebase_options.dart';
import '../../main.dart';
import '../../services/archive/interfaces/IFirebaseArchiveDal.dart';
import '../../services/auth/AuthManager.dart';
import '../../services/auth/FirebaseAuthDal.dart';
import '../../services/auth/interfaces/IAuthManager.dart';
import '../../services/auth/interfaces/IFirebaseAuthDal.dart';
import '../../services/note/FirebaseNoteDal.dart';
import '../../services/note/FirebaseNoteManager.dart';
import '../../services/note/interfaces/IFirebaseNoteDal.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../services/trash/FirebaseTrashDal.dart';
import '../../services/trash/FirebaseTrashManager.dart';
import '../../services/trash/interfaces/IFirebaseTrashDal.dart';
import '../../services/trash/interfaces/IFirebaseTrashManager.dart';
import 'IConfigureDependencies.dart';

class FirebaseConfigureDependencies implements IConfigureDependencies {
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final IFirebaseAuthDal authDal = FirebaseAuthDal();
    final IFirebaseNoteDal noteDal = FirebaseNoteDal();
    final IFirebaseArchiveDal archiveDal = FirebaseArchiveDal();
    final IFirebaseTrashDal trashDal = FirebaseTrashDal();

    final IAuthManager authManager = AuthManager(authDal: authDal);
    final IFirebaseNoteManager noteManager = FirebaseNoteManager(
      noteDal: noteDal,
      authDal: authDal,
      trashDal: trashDal,
      archiveDal: archiveDal,
    );
    final IFirebaseArchiveManager archiveManager = FirebaseArchiveManager(
      archiveDal: archiveDal,
      authDal: authDal,
      noteDal: noteDal,
      trashDal: trashDal,
    );

    final IFirebaseTrashManager trashManager = FirebaseTrashManager(
      noteDal: noteDal,
      authDal: authDal,
      trashDal: trashDal,
    );

    locator.registerLazySingleton<IAuthManager>(() => authManager);
    locator.registerLazySingleton<IFirebaseNoteManager>(() => noteManager);
    locator
        .registerLazySingleton<IFirebaseArchiveManager>(() => archiveManager);
    locator.registerLazySingleton<IFirebaseTrashManager>(() => trashManager);
  }
}
