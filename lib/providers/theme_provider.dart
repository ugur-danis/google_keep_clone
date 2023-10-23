import 'package:flutter/material.dart';

import '../utils/theme/interfaces/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme _appTheme;

  ThemeProvider(this._appTheme);

  AppTheme get getAppTheme => _appTheme;

  ThemeData get getTheme => _appTheme.theme;

  set setTheme(AppTheme appTheme) {
    _appTheme = appTheme;
    _appTheme.setDefaultSystemUIOverlayStyle();
    notifyListeners();
  }
}
