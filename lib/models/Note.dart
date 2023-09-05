// ignore_for_file: file_names
import 'package:uuid/uuid.dart';

class Note {
  late final String id;
  String title;
  String note;
  DateTime lastEditDate;

  Note({
    this.title = '',
    this.note = '',
    required this.lastEditDate,
  }) {
    id = const Uuid().v4();
  }
}
