import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
import '../models/Note.dart';
import '../services/note/interfaces/IFirebaseNoteManager.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  late final IFirebaseNoteManager _noteManager;

  NoteProvider() {
    _noteManager = locator.get<IFirebaseNoteManager>();
  }

  List<Note> get notes => _notes;

  NoteProvider configure() {
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

  Function deleteNoteDelayed(Note note,
      [Duration duration = const Duration(seconds: 6)]) {
    _notes.remove(note);
    notifyListeners();

    final Timer timer = Timer(duration, () => deleteNote(note));

    return () {
      timer.cancel();
      _notes.add(note);
      notifyListeners();
    };
  }

  void _clearNotesAndAddAll(List<Note> notes) {
    _notes.clear();
    _notes.addAll(notes);
  }
}
