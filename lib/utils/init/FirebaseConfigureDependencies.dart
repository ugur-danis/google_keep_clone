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
import '../../services/recycle_bin/FirebaseRecycleBinDal.dart';
import '../../services/recycle_bin/FirebaseRecycleBinManager.dart';
import '../../services/recycle_bin/interfaces/IFirebaseRecycleBinDal.dart';
import '../../services/recycle_bin/interfaces/IFirebaseRecycleBinManager.dart';
import 'IConfigureDependencies.dart';

class FirebaseConfigureDependencies implements IConfigureDependencies {
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final IFirebaseAuthDal authDal = FirebaseAuthDal();
    final IAuthManager authManager = AuthManager(authDal: authDal);
    final IFirebaseNoteDal noteDal = FirebaseNoteDal();
    final IFirebaseRecycleBinDal recycleBinDal = FirebaseRecycleBinDal();
    final IFirebaseNoteManager noteManager = FirebaseNoteManager(
        noteDal: noteDal, authDal: authDal, recycleBinDal: recycleBinDal);
    final IFirebaseRecycleBinManager recycleBinManager =
        FirebaseRecycleBinManager(
            noteDal: noteDal, authDal: authDal, recycleBinDal: recycleBinDal);
    final IFirebaseArchiveDal archiveDal = FirebaseArchiveDal();
    final IFirebaseArchiveManager archiveManager = FirebaseArchiveManager(
        archiveDal: archiveDal, authDal: authDal, noteDal: noteDal);

    locator.registerLazySingleton<IAuthManager>(() => authManager);
    locator.registerLazySingleton<IFirebaseNoteManager>(() => noteManager);
    locator.registerLazySingleton<IFirebaseRecycleBinManager>(
        () => recycleBinManager);
    locator
        .registerLazySingleton<IFirebaseArchiveManager>(() => archiveManager);
  }
}
