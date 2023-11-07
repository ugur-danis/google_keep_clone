// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/fetch_query.dart';
import '../../../utils/types/add_listener_callback.dart';
import 'INoteManager.dart';

abstract class IFirebaseNoteManager extends INoteManager {
  void addListener(AddListenerCallback<Note> callback, [FetchQuery? query]);
  void removeListener();
}
