// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/interfaces/IEntity.dart';

class Note extends IEntity {
  String? id;
  String? userId;
  String? title;
  String? note;
  int? color;
  DateTime? lastEditDate;
  bool pinned;

  Note({
    this.id,
    this.userId,
    this.lastEditDate,
    this.color,
    this.title = '',
    this.note = '',
    this.pinned = false,
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
      color: data?['color'],
      pinned: data?['pinned'],
      lastEditDate: (data?['lastEditDate'] as Timestamp).toDate(),
    );
  }

  Note.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        title = data['title'],
        note = data['note'],
        color = data['color'],
        pinned = data['pinned'],
        lastEditDate = (data['lastEditDate'] as Timestamp).toDate();

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'note': note,
        'color': color,
        'pinned': pinned,
        'lastEditDate': Timestamp.fromDate(lastEditDate!),
      };

  Note copyWith({
    String? id,
    String? userId,
    String? title,
    String? note,
    int? color,
    bool? pinned,
    DateTime? lastEditDate,
  }) =>
      Note(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        note: note ?? this.note,
        color: color ?? this.color,
        pinned: pinned ?? this.pinned,
        lastEditDate: lastEditDate ?? this.lastEditDate,
      );

  @override
  int get hashCode =>
      Object.hash(id, userId, title, note, lastEditDate, pinned, color);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          title == other.title &&
          note == other.note &&
          color == other.color &&
          pinned == other.pinned &&
          lastEditDate == other.lastEditDate;
}
