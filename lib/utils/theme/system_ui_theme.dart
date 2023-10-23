import 'package:flutter/services.dart';

class SystemUITheme {
  SystemUITheme._();

  static void setStatusAndNavBar({
    Color? statusBarColor,
    Color? navBarColor,
    Color? navBarDividerColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: navBarColor,
      systemNavigationBarDividerColor: navBarDividerColor,
    ));
  }
}
