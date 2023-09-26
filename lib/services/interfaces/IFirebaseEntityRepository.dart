// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../utils/types/Query.dart';
import 'IEntity.dart';
import 'IEntityRepository.dart';

abstract class IFirebaseEntityRepository<T extends IEntity>
    extends IEntityRepository<T> {
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]);
}
