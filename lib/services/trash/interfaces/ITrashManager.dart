// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/fetch_query.dart';

abstract class ITrashManager {
  Future<List<Note>> getAll([FetchQuery? query]);
  Future<void> restore(Note note);
  Future<void> allDelete();
  Future<void> delete(Note note);
}
