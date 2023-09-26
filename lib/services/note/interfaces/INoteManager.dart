// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/Query.dart';

abstract class INoteManager {
  Future<Note?> get([FetchQuery? querie]);
  Future<List<Note>> getAll([FetchQuery? querie]);
  Future<void> add(Note note);
  Future<void> update(Note note);
  Future<void> delete(Note note);
}
