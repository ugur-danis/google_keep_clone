// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/FetchQuery.dart';
import 'ITrashManager.dart';

abstract class IFirebaseTrashManager extends ITrashManager {
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]);
  void removeListener();
}
