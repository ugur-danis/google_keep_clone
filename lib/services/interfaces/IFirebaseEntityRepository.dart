// ignore_for_file: file_names

import '../../utils/types/FetchQuery.dart';
import 'IEntity.dart';
import 'IEntityRepository.dart';

abstract class IFirebaseEntityRepository<T extends IEntity>
    extends IEntityRepository<T> {
  void addListener(Function(List<T>) callback, [FetchQuery? querie]);
  void removeListener();
}
