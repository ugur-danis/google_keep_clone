// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/FetchQuery.dart';
import 'IArchiveManager.dart';

abstract class IFirebaseArchiveManager extends IArchiveManager {
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]);
  void removeListener();
}
