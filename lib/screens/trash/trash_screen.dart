import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/Note.dart';
import '../../services/trash/interfaces/IFirebaseTrashManager.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/note_grid.dart';
import '../../widgets/note_item.dart';

part 'trash_screen_model.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({super.key});

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> with _TrashScreenMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            _selectedNotes.isEmpty ? buildAppBar() : buildItemSelectedAppBar(),
        drawer: const DrawerMenu(screen: DrawerMenuScreens.trash),
        body: buildContent(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      title: Text('Trash', style: Theme.of(context).textTheme.titleMedium),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: deleteAllNotes,
              child: const Text('Empty Trash Bin'),
            ),
          ],
        ),
      ],
    );
  }

  AppBar buildItemSelectedAppBar() {
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
          onPressed: restoreSelectedNotes,
          icon: const Icon(Icons.restore),
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: deleteSelectedNotes,
              child: const Text('Delete completely'),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildContent() {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          if (snapshot.data.length < 1) {
            return buildNoNotesText(context);
          }
          return buildGridView(snapshot);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Center buildNoNotesText(BuildContext context) {
    return Center(
        child: Text(
      'No notes in trash',
      style: Theme.of(context).textTheme.bodyLarge,
    ));
  }

  NoteGrid buildGridView(AsyncSnapshot<dynamic> snapshot) {
    return NoteGrid(
      items: snapshot.data,
      itemBuilder: (context, index) => buildNoteItem(snapshot.data[index]),
    );
  }

  NoteItem buildNoteItem(Note note) {
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
