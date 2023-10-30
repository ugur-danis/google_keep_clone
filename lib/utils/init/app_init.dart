import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../theme/dark_theme.dart';
import 'IConfigureDependencies.dart';

class AppInit {
  final IConfigureDependencies _configureDependencies;

  AppInit({required IConfigureDependencies configureDependencies})
      : _configureDependencies = configureDependencies;

  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ThemeProvider(DarkTheme())),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ];

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureDependencies.init();
  }
}
