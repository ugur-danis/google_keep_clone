// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/FetchQuery.dart';

abstract class IRecycleBinManager {
  Future<List<Note>> getAll([FetchQuery? querie]);
  Future<void> restore(Note note);
  Future<void> allDelete();
  Future<void> delete(Note note);
}
