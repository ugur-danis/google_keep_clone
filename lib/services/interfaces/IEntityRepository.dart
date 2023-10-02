// ignore_for_file: file_names

import '../../utils/types/FetchQuery.dart';
import 'IEntity.dart';

abstract class IEntityRepository<T extends IEntity> {
  Future<T?> get([FetchQuery? querie]);
  Future<List<T>> getAll([FetchQuery? querie]);
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(T entity);
}
