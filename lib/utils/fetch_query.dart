import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFetchQuery {
  FetchQuery copyWith({
    String? field,
    Object? value,
    FetchQueryOperation? operation,
  });
}

class FetchQuery implements IFetchQuery {
  FetchQuery({
    required this.field,
    required this.value,
    required this.operation,
  });

  final String field;
  final Object value;
  final FetchQueryOperation operation;

  @override
  FetchQuery copyWith({
    String? field,
    Object? value,
    FetchQueryOperation? operation,
  }) =>
      FetchQuery(
        field: field ?? this.field,
        value: value ?? this.value,
        operation: operation ?? this.operation,
      );
}

enum FetchQueryOperation {
  isEqualTo,
  isGreaterThanOrEqualTo,
  isLessThan,
  stringContains,
}

extension FetchQueryOperationExtension on FetchQueryOperation {
  Filter toFirebaseQuery(FetchQuery query) {
    switch (this) {
      case FetchQueryOperation.isEqualTo:
        return Filter(query.field, isEqualTo: query.value);
      case FetchQueryOperation.isGreaterThanOrEqualTo:
        return Filter(query.field, isGreaterThanOrEqualTo: query.value);
      case FetchQueryOperation.isLessThan:
        return Filter(query.field, isLessThan: query.value);
      case FetchQueryOperation.stringContains:
        return Filter.and(
          Filter(query.field, isGreaterThanOrEqualTo: query.value),
          Filter(query.field, isLessThan: '${query.value}z'),
        );
    }
  }
}
