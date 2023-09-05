import 'package:flutter/material.dart';
import 'package:google_keep_clone/providers/note_provider.dart';
import 'package:provider/provider.dart';
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
      _note = Note(lastEditDate: DateTime.now());
      Future.delayed(const Duration(seconds: 1), () {
        context.read<NoteProvider>().addNote(_note);
      });
    } else {
      _note = context
          .read<NoteProvider>()
          .notes
          .singleWhere((element) => element.id == widget.noteId);
    }

    _titleEditingController.text = _note.title;
    _noteEditingController.text = _note.note;

    _titleEditingController.addListener(() {
      setState(() {
        _note.title = _titleEditingController.text;
      });
    });

    _noteEditingController.addListener(() {
      setState(() {
        _note.note = _noteEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: Row(
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
              'Düzenlenme saati: 15:06',
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
            ),
          ),
          const SizedBox(width: 48),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
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
    );
  }
}
