// ignore_for_file: file_names

import '../../models/Note.dart';
import 'INoteService.dart';

abstract class IFirebaseNoteService extends INoteService {
  IFirebaseNoteService addListener(Function(List<Note>) callback);
}
