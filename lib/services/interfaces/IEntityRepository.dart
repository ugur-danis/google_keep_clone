// ignore_for_file: file_names
import 'IEntity.dart';

abstract class IEntityRepository<T extends IEntity> {
  Future<T?> get();
  Future<List<T>> getAll();
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(T entity);
}
