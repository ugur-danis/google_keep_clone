import 'package:flutter/material.dart';
import 'package:google_keep_clone/screens/home_screen.dart';

import 'constants/color.dart';

void main() {
  runApp(MyApp());
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
    scaffoldBackgroundColor: CustomColors.umbra,
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
