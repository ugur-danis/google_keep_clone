// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/interfaces/IEntity.dart';

class Note extends IEntity {
  String? id;
  String? userId;
  String? title;
  String? note;
  DateTime? lastEditDate;

  Note({
    this.id,
    this.userId,
    this.lastEditDate,
    this.title = '',
    this.note = '',
  });

  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Note(
      id: data?['id'],
      userId: data?['userId'],
      title: data?['title'],
      note: data?['note'],
      lastEditDate: (data?['lastEditDate'] as Timestamp).toDate(),
    );
  }

  Note.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        title = data['title'],
        note = data['note'],
        lastEditDate = (data['lastEditDate'] as Timestamp).toDate();

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'note': note,
        'lastEditDate': Timestamp.fromDate(lastEditDate!),
      };

  Note copyWith({
    String? id,
    String? userId,
    String? title,
    String? note,
    DateTime? lastEditDate,
  }) =>
      Note(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        note: note ?? this.note,
        lastEditDate: lastEditDate ?? this.lastEditDate,
      );

  @override
  int get hashCode => Object.hash(id, userId, title, note, lastEditDate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          title == other.title &&
          note == other.note &&
          lastEditDate == other.lastEditDate;
}
