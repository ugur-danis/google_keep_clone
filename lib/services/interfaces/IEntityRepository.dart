// ignore_for_file: file_names

import '../../utils/fetch_query.dart';
import 'IEntity.dart';

abstract class IEntityRepository<T extends IEntity> {
  Future<T?> get([FetchQuery? query]);
  Future<List<T>> getAll([FetchQuery? query]);
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(T entity);
}
