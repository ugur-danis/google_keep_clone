// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/FetchQuery.dart';
import '../../../utils/types/add_listener_callback.dart';
import 'ITrashManager.dart';

abstract class IFirebaseTrashManager extends ITrashManager {
  void addListener(AddListenerCallback<Note> callback, [FetchQuery? querie]);
  void removeListener();
}
