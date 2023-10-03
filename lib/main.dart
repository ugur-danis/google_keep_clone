import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'providers/auth_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'utils/init/FirebaseConfigureDependencies.dart';
import 'utils/init/app_init.dart';
import 'utils/theme/dark_theme.dart';

final GetIt locator = GetIt.instance;

Future<void> main() async {
  final AppInit appInit = AppInit(
    configureDependencies: FirebaseConfigureDependencies(),
  );
  await appInit.init();

  runApp(
    MultiProvider(
      providers: appInit.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Keep Clone',
      theme: DarkTheme().theme,
      home: buildHome(context),
    );
  }

  FutureBuilder<bool> buildHome(BuildContext context) {
    return FutureBuilder<bool>(
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
    );
  }
}
