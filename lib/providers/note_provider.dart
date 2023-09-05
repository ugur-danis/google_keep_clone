import 'package:flutter/material.dart';

import '../models/Note.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [
    Note(title: 'Selam', note: 'Test note', lastEditDate: DateTime.now()),
    Note(title: 'Selam', note: 'Test note', lastEditDate: DateTime.now()),
    Note(title: 'Selam', note: 'Test note', lastEditDate: DateTime.now()),
    Note(title: 'Selam', note: 'Test note', lastEditDate: DateTime.now()),
  ];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }
}
