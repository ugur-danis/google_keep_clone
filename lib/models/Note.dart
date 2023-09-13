// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/interfaces/IEntity.dart';

class Note extends IEntity {
  String? id;
  String? title;
  String? note;
  DateTime? lastEditDate;

  Note({
    this.id,
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
      title: data?['title'],
      note: data?['note'],
      lastEditDate: (data?['lastEditDate'] as Timestamp).toDate(),
    );
  }

  Note.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        note = data['note'],
        lastEditDate = (data['lastEditDate'] as Timestamp).toDate();

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'note': note,
        'lastEditDate': Timestamp.fromDate(lastEditDate!),
      };

  @override
  String toString() =>
      "Response(id: $id,title: $title,note: $note,lastEditDate: $lastEditDate)";
}
