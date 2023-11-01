// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IEntity<T> {
  String? id;

  T fromMap(Map<String, Object?> data);

  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw ('$snapshot data is null');
    }
    // fixme
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromMap(value);
  }

  Map<String, Object?> toMap();
}
