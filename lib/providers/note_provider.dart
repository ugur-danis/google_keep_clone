import 'package:flutter/material.dart';

import '../main.dart';
import '../models/Note.dart';
import '../services/note/interfaces/IFirebaseNoteManager.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  late final IFirebaseNoteManager _noteManager;

  NoteProvider() {
    _noteManager = locator.get<IFirebaseNoteManager>();
    _noteManager.addListener(_handleNotesChange);

    _getNotes();
  }

  List<Note> get notes => _notes;

  void _handleNotesChange(List<Note> notes) {
    _notes.clear();
    _notes.addAll(notes);
    notifyListeners();
  }

  void _getNotes() async {
    await _noteManager.getAll();
    notifyListeners();
  }

  void addNote(Note note) async {
    _noteManager.add(note);
    notifyListeners();
  }

  void updateNote(Note note) async {
    await _noteManager.update(note);
    notifyListeners();
  }

  void deleteNote(Note note) async {
    await _noteManager.delete(note);
    notifyListeners();
  }
}
