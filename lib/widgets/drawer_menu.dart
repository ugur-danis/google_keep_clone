import 'package:flutter/material.dart';
import '../constants/color.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int _selectedIndex = 0;

  void onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
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
              child: const Text('Google Keep', style: TextStyle(fontSize: 24)),
            ),
            ListTile(
              selected: _selectedIndex == 0,
              title: const Text('Notes'),
              leading: const Icon(Icons.lightbulb_outlined),
              onTap: () => onItemTapped(0),
            ),
            ListTile(
              selected: _selectedIndex == 1,
              title: const Text('Reminders'),
              leading: const Icon(Icons.notifications_none),
              onTap: () => onItemTapped(1),
            ),
            ListTile(
              selected: _selectedIndex == 2,
              title: const Text('Create new tag'),
              leading: const Icon(Icons.add),
              onTap: () => onItemTapped(2),
            ),
            ListTile(
              selected: _selectedIndex == 3,
              title: const Text('Archive'),
              leading: const Icon(Icons.archive_outlined),
              onTap: () => onItemTapped(3),
            ),
            ListTile(
              selected: _selectedIndex == 4,
              title: const Text('Recycle Bin'),
              leading: const Icon(Icons.delete_outlined),
              onTap: () => onItemTapped(4),
            ),
            ListTile(
              selected: _selectedIndex == 5,
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () => onItemTapped(5),
            ),
          ],
        ),
      ),
    );
  }
}
