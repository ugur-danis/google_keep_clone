import 'package:flutter/material.dart';
import 'package:google_keep_clone/screens/home_screen.dart';

import 'constants/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData.dark(useMaterial3: true).copyWith(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: CustomColors.floatingActionButtonBg,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: CustomColors.bottomAppBarBg,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStatePropertyAll(Colors.blue.shade100),
      thumbColor: MaterialStatePropertyAll(Colors.blue.shade900),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Keep Clone',
      theme: theme,
      home: const SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}
