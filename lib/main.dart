import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_keep_clone/providers/auth_provider.dart';
import 'package:google_keep_clone/services/auth/interfaces/IAuthDal.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'constants/color.dart';
import 'providers/note_provider.dart';
import 'screens/home_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'services/auth/AuthManager.dart';
import 'services/auth/FirebaseAuthDal.dart';
import 'services/auth/interfaces/IAuthManager.dart';

final GetIt locator = GetIt.instance;

Future<void> main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
}

void configureDependencies() {
  locator.registerSingleton<IAuthDal>(FirebaseAuthDal());
  locator.registerSingleton<IAuthManager>(
      AuthManager(authDal: locator.get<IAuthDal>()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.white54,
    ),
    dialogBackgroundColor: CustomColors.inTheDark,
    dividerTheme: const DividerThemeData(
      color: Colors.white38,
      thickness: 1,
    ),
    searchBarTheme: const SearchBarThemeData(
      padding: MaterialStatePropertyAll(EdgeInsets.zero),
      shadowColor: MaterialStatePropertyAll(Colors.transparent),
      overlayColor: MaterialStatePropertyAll(CustomColors.caviar),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
      textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 14)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: CustomColors.deepSpace,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: CustomColors.caviar,
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(CustomColors.ladyNicole),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColors.caviar,
      actionsIconTheme: IconThemeData(color: CustomColors.ladyNicole),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStatePropertyAll(Colors.blue.shade100),
      thumbColor: MaterialStatePropertyAll(Colors.blue.shade900),
    ),
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: Colors.blue),
    ),
    scaffoldBackgroundColor: CustomColors.umbra,
    checkboxTheme: const CheckboxThemeData(
      checkColor: MaterialStatePropertyAll(Colors.blue),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Keep Clone',
      theme: theme,
      home: FutureBuilder<bool>(
        future: context.read<AuthProvider>().checkSession(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.data == true) {
            return const HomeScreen();
          }
          return const SignInScreen();
        },
      ),
    );
  }
}
