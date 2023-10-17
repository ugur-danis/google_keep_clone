import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../providers/auth_provider.dart';
import 'IConfigureDependencies.dart';

class AppInit {
  final IConfigureDependencies _configureDependencies;

  AppInit({required IConfigureDependencies configureDependencies})
      : _configureDependencies = configureDependencies;

  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ];

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureDependencies.init();
  }
}
