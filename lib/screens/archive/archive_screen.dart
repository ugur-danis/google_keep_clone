import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/Note.dart';
import '../../services/archive/interfaces/IFirebaseArchiveManager.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/illustrated_message.dart';
import '../../widgets/note_item.dart';
import '../search_note/search_note_screen.dart';

part 'archive_screen_model.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen>
    with _ArchiveScreenMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            _selectedNotes.isEmpty ? buildAppBar() : buildItemSelectedAppBar(),
        drawer: const DrawerMenu(screen: DrawerMenuScreens.archive),
        body: buildContent(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      title: Text('Archive', style: Theme.of(context).textTheme.titleMedium),
      actions: [
        IconButton(
          onPressed: navToSearchScreen,
          icon: const Icon(Icons.search_outlined),
        ),
        IconButton(
          onPressed: toggleGridCrossAxisCount,
          icon: const Icon(Icons.view_agenda_outlined),
        ),
      ],
    );
  }

  AppBar buildItemSelectedAppBar() {
    final List<PopupMenuEntry> popupMenuItems = [
      PopupMenuItem(
        onTap: unarchiveNote,
        child: const Text('Unarchive'),
      ),
      PopupMenuItem(
        onTap: deleteNote,
        child: const Text('Delete'),
      ),
    ];

    if (_selectedNotes.length == 1) {
      popupMenuItems.addAll([
        PopupMenuItem(
          onTap: createNoteCopy,
          child: const Text('Create a copy'),
        ),
        PopupMenuItem(
          onTap: () {},
          child: const Text('Send'),
        )
      ]);
    }

    popupMenuItems.add(PopupMenuItem(
      onTap: () {},
      child: const Text('Copy to Google Docs'),
    ));

    return AppBar(
      titleSpacing: 0,
      title: Text(
        _selectedNotes.length.toString(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: IconButton(
        onPressed: clearSelectedNotes,
        icon: const Icon(Icons.close),
      ),
      actions: [
        IconButton(
          onPressed: updateNotePinned,
          icon: const Icon(Icons.push_pin_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notification_add_sharp),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.color_lens_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.label_outline),
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) => popupMenuItems),
      ],
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data.length < 1) {
                return buildNoNotesMessage(context);
              }
              return buildGridView(snapshot);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  IllustratedMessage buildNoNotesMessage(BuildContext context) {
    return const IllustratedMessage(
      icon: Icons.archive_outlined,
      text: 'Your archived notes appear here',
    );
  }

  Expanded buildGridView(AsyncSnapshot<dynamic> snapshot) {
    return Expanded(
      child: GridView.count(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        crossAxisCount: _gridCrossAxisCount,
        children: List.generate(
          snapshot.data.length,
          (index) => buildNoteItem(snapshot, index),
        ),
      ),
    );
  }

  NoteItem buildNoteItem(AsyncSnapshot<dynamic> snapshot, int index) {
    final Note note = snapshot.data[index];

    return NoteItem(
      note: note,
      isEditable: false,
      selected: _selectedNotes.contains(note),
      onSelected: (bool isSelected) {
        onChangeSelectedNotes(note, isSelected);
      },
    );
  }
}
