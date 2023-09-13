// ignore_for_file: file_names

import '../../models/Note.dart';

abstract class INoteService {
  Future<Note?> get();
  Future<List<Note>> getAll();
  Future<void> add(Note note);
  Future<void> update(Note note);
  Future<void> delete(Note note);
}
