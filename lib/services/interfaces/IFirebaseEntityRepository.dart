// ignore_for_file: file_names

import '../../utils/fetch_query.dart';
import '../../utils/types/add_listener_callback.dart';
import 'IEntity.dart';
import 'IEntityRepository.dart';

abstract class IFirebaseEntityRepository<T extends IEntity>
    extends IEntityRepository<T> {
  void addListener(AddListenerCallback<T> callback, [FetchQuery? query]);
  void removeListener();
}
