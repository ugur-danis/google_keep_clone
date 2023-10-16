import 'package:flutter/material.dart';

import '../main.dart';
import '../models/Note.dart';
import '../services/note/interfaces/IFirebaseNoteManager.dart';

class HomeProvider extends ChangeNotifier {
  late final IFirebaseNoteManager _noteManager;
  final List<Note> _notes = [];

  HomeProvider() : _noteManager = locator.get<IFirebaseNoteManager>();

  List<Note> get notes => _notes;

  HomeProvider configure() {
    _noteManager.addListener(_handleNotesChange);
    return this;
  }

  void _handleNotesChange(List<Note> notes) {
    _clearNotesAndAddAll(notes);
    notifyListeners();
  }

  void getNotes() async {
    List<Note> notes = await _noteManager.getAll();
    _clearNotesAndAddAll(notes);
    notifyListeners();
  }

  void addNote(Note note) async {
    _noteManager.add(note);
  }

  void updateNote(Note note) async {
    _noteManager.update(note);
  }

  void restoreNote(Note note) async {
    _noteManager.restore(note);
  }

  void moveNoteToRecycleBin(Note note) async {
    _noteManager.moveToRecycleBin(note);
  }

  void _clearNotesAndAddAll(List<Note> notes) {
    _notes.clear();
    _notes.addAll(notes);
  }
}
