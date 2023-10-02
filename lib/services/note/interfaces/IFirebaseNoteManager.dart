// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/Query.dart';
import 'INoteManager.dart';

abstract class IFirebaseNoteManager extends INoteManager {
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]);
  void removeListener();
}
