import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../screens/archive/archive_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/trash/trash_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../utils/theme/dark_theme.dart';

enum DrawerMenuScreens<int> {
  notes,
  reminders,
  tag,
  archive,
  trash,
  settings;
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.screen,
  });

  final DrawerMenuScreens screen;

  void navTo(BuildContext context, Widget widget) {
    if (widget != const HomeScreen()) {
      DarkTheme.setDefaultSystemUIOverlayStyle();
    }
    Navigator.of(context).pop(); // close the drawer
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        textColor: CustomColors.drawerTextColor,
        iconColor: CustomColors.drawerIconColor,
        selectedColor: CustomColors.drawerTextColor,
        selectedTileColor: CustomColors.drawerActiveTileColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Google Keep',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ListTile(
              selected: screen == DrawerMenuScreens.notes,
              title: const Text('Notes'),
              leading: const Icon(Icons.lightbulb_outlined),
              onTap: () => navTo(context, const HomeScreen()),
            ),
            ListTile(
              selected: screen == DrawerMenuScreens.reminders,
              title: const Text('Reminders'),
              leading: const Icon(Icons.notifications_none),
              onTap: () => {},
            ),
            ListTile(
              selected: screen == DrawerMenuScreens.tag,
              title: const Text('Create new tag'),
              leading: const Icon(Icons.add),
              onTap: () => {},
            ),
            ListTile(
              selected: screen == DrawerMenuScreens.archive,
              title: const Text('Archive'),
              leading: const Icon(Icons.archive_outlined),
              onTap: () => navTo(context, const ArchiveScreen()),
            ),
            ListTile(
              selected: screen == DrawerMenuScreens.trash,
              title: const Text('Trash'),
              leading: const Icon(Icons.delete_outlined),
              onTap: () => navTo(context, const TrashScreen()),
            ),
            ListTile(
              selected: screen == DrawerMenuScreens.settings,
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () => navTo(context, const SettingsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
