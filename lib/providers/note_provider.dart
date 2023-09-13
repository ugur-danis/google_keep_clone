import 'package:flutter/material.dart';

import '../models/Note.dart';
import '../services/FirebaseNoteDal.dart';
import '../services/FirebaseNoteService.dart';
import '../services/interfaces/INoteService.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  late final INoteService _noteService;

  NoteProvider() {
    _noteService = FirebaseNoteService(noteDal: FirebaseNoteDal())
        .addListener(_handleNotesChange);

    _getNotes();
  }

  List<Note> get notes => _notes;

  void _handleNotesChange(List<Note> notes) {
    _notes.clear();
    _notes.addAll(notes);
    notifyListeners();
  }

  void _getNotes() async {
    await _noteService.getAll();
    notifyListeners();
  }

  void addNote(Note note) async {
    _noteService.add(note);
    notifyListeners();
  }

  void updateNote(Note note) async {
    await _noteService.update(note);
    notifyListeners();
  }

  void deleteNote(Note note) async {
    await _noteService.delete(note);
    notifyListeners();
  }
}
