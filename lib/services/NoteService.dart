// ignore_for_file: file_names

import '../models/Note.dart';
import 'interfaces/INoteDal.dart';
import 'interfaces/INoteService.dart';

class NoteService implements INoteService {
  final INoteDal _noteDal;

  NoteService({required INoteDal noteDal}) : _noteDal = noteDal;

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
}
