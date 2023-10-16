import 'package:flutter/material.dart';

import '../../constants/color.dart';

class DarkTheme {
  late final ThemeData theme;

  DarkTheme() {
    theme = ThemeData.dark(useMaterial3: true).copyWith(
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
      popupMenuTheme: const PopupMenuThemeData(
        color: CustomColors.caviar,
      ),
    );
  }
}
