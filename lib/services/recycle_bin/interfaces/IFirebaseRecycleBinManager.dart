// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../../utils/types/FetchQuery.dart';
import 'IRecycleBinManager.dart';

abstract class IFirebaseRecycleBinManager extends IRecycleBinManager {
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]);
  void removeListener();
}
