import 'package:flutter/material.dart';
import 'package:google_keep_clone/utils/date_formatter.dart';
import 'package:provider/provider.dart';

import '../providers/note_provider.dart';
import '../models/Note.dart';

class NewNote extends StatefulWidget {
  NewNote({Key? key, this.noteId = ''}) : super(key: key) {
    isNewNote = noteId.isEmpty;
  }

  final String noteId;
  late final bool isNewNote;

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  late final Note _note;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isNewNote) {
      _note = Note(title: '', note: '', lastEditDate: DateTime.now());
      Future.delayed(const Duration(seconds: 1), () {
        context.read<NoteProvider>().addNote(_note);
      });
    } else {
      _note = context
          .read<NoteProvider>()
          .notes
          .singleWhere((element) => element.id == widget.noteId);
    }

    _titleEditingController.text = _note.title!;
    _noteEditingController.text = _note.note!;

    _titleEditingController.addListener(() {
      setState(() {
        _note.title = _titleEditingController.text;
      });
      context.read<NoteProvider>().updateNote(_note);
    });

    _noteEditingController.addListener(() {
      setState(() {
        _note.note = _noteEditingController.text;
      });
      context.read<NoteProvider>().updateNote(_note);
    });
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete_outlined),
            title: const Text('Delete'),
            onTap: () {
              context.read<NoteProvider>().deleteNote(_note);
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          if (_note.note!.isEmpty && _note.title!.isEmpty) {
            context.read<NoteProvider>().deleteNote(_note);
          }

          return Future.value(true);
        },
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
          onPressed: () => showBottomSheet(context),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
