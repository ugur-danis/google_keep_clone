import 'package:flutter/material.dart';

import '../utils/theme/interfaces/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  late AppTheme _appTheme;

  ThemeProvider(AppTheme appTheme) {
    setTheme(appTheme);
  }

  AppTheme get getAppTheme => _appTheme;

  ThemeData get getTheme => _appTheme.theme;

  void setTheme(AppTheme appTheme) {
    _appTheme = appTheme;
    _appTheme.setDefaultSystemUIOverlayStyle();
    notifyListeners();
  }
}
