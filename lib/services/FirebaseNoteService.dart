// ignore_for_file: file_names

import 'interfaces/IFirebaseNoteDal.dart';
import 'interfaces/IFirebaseNoteService.dart';
import '../models/Note.dart';

class FirebaseNoteService implements IFirebaseNoteService {
  final IFirebaseNoteDal _noteDal;

  FirebaseNoteService({
    required IFirebaseNoteDal noteDal,
  }) : _noteDal = noteDal;

  @override
  Future<void> add(Note note) async {
    _noteDal.add(note);
  }

  @override
  Future<void> delete(Note note) async {
    _noteDal.delete(note);
  }

  @override
  Future<Note?> get() async {
    return _noteDal.get();
  }

  @override
  Future<List<Note>> getAll() async {
    return _noteDal.getAll();
  }

  @override
  Future<void> update(Note note) async {
    _noteDal.update(note);
  }

  @override
  IFirebaseNoteService addListener(Function(List<Note> p1) callback) {
    _noteDal.addListener(callback);
    return this;
  }
}
