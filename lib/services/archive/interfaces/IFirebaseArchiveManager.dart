// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/FetchQuery.dart';
import '../../../utils/types/add_listener_callback.dart';
import 'IArchiveManager.dart';

abstract class IFirebaseArchiveManager extends IArchiveManager {
  void addListener(AddListenerCallback<Note> callback, [FetchQuery? querie]);
  void removeListener();
}
