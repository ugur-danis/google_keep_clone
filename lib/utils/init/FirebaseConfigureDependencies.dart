// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../../main.dart';
import '../../services/auth/AuthManager.dart';
import '../../services/auth/FirebaseAuthDal.dart';
import '../../services/auth/interfaces/IAuthManager.dart';
import '../../services/auth/interfaces/IFirebaseAuthDal.dart';
import '../../services/note/FirebaseNoteDal.dart';
import '../../services/note/FirebaseNoteManager.dart';
import '../../services/note/interfaces/IFirebaseNoteDal.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import 'IConfigureDependencies.dart';

class FirebaseConfigureDependencies implements IConfigureDependencies {
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final IFirebaseAuthDal authDal = FirebaseAuthDal();
    final IAuthManager authManager = AuthManager(authDal: authDal);
    final IFirebaseNoteDal noteDal = FirebaseNoteDal();
    final IFirebaseNoteManager noteManager =
        FirebaseNoteManager(noteDal: noteDal, authDal: authDal);

    locator.registerLazySingleton<IAuthManager>(() => authManager);
    locator.registerLazySingleton<IFirebaseNoteManager>(() => noteManager);
    locator.registerSingleton<IAuthManager>(authManager);
    locator.registerSingleton<IFirebaseNoteManager>(noteManager);
  }
}
