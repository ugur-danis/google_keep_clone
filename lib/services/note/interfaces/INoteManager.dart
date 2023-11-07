// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/fetch_query.dart';

abstract class INoteManager {
  Future<Note?> get([FetchQuery? query]);
  Future<List<Note>> getAll([FetchQuery? query]);
  Future<void> add(Note note);
  Future<void> update(Note note);
  Future<void> delete(Note note);
  Future<void> restore(Note note);
  Future<void> moveToTrash(Note note);
  Future<void> moveToArchive(Note note);
}
