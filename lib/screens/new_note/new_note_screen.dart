library new_note;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/note_provider.dart';
import '../../models/Note.dart';
import '../../utils/date_formatter.dart';

part 'new_note_view_model.dart';

class NewNoteScreen extends StatefulWidget {
  NewNoteScreen({Key? key, this.noteId = ''}) : super(key: key) {
    isNewNote = noteId.isEmpty;
  }

  final String noteId;
  late final bool isNewNote;

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen>
    with _NewNoteScreenMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.push_pin_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notification_add_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.archive_outlined),
              ),
            ],
          ),
          bottomNavigationBar: buildBottomNavigationBar(context),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _titleEditingController,
                  style: Theme.of(context).textTheme.titleLarge!,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Başlık',
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: _noteEditingController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Not',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showActionList() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete_outlined),
            title: const Text('Delete'),
            onTap: deleteNote,
          ),
        ],
      ),
    );
  }

  Row buildBottomNavigationBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_box_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.color_lens_outlined),
        ),
        Expanded(
          child: Text(
            DateFormatter.difference(to: _note.lastEditDate!),
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
          ),
        ),
        const SizedBox(width: 48),
        IconButton(
          onPressed: showActionList,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
