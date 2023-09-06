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

  void updateNote(Note note) {
    int index = _notes.indexWhere((element) => element.id == note.id);
    if (index == -1) return;

    _notes[index] = note;

    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
}
