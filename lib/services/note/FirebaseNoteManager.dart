// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/types/FetchQuery.dart';
import '../auth/interfaces/IFirebaseAuthDal.dart';
import 'interfaces/IFirebaseNoteDal.dart';
import 'interfaces/IFirebaseNoteManager.dart';

class FirebaseNoteManager implements IFirebaseNoteManager {
  final IFirebaseNoteDal _noteDal;
  final IFirebaseAuthDal _authDal;

  FirebaseNoteManager({
    required IFirebaseNoteDal noteDal,
    required IFirebaseAuthDal authDal,
  })  : _noteDal = noteDal,
        _authDal = authDal;

  @override
  Future<void> add(Note note) async {
    _noteDal.add(note);
  }

  @override
  Future<void> delete(Note note) async {
    _noteDal.delete(note);
  }

  @override
  Future<Note?> get([FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    return _noteDal.get(querie);
  }

  @override
  Future<List<Note>> getAll([FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    return _noteDal.getAll(querie);
  }

  @override
  Future<void> update(Note note) async {
    _noteDal.update(note);
  }

  @override
  void addListener(Function(List<Note> p1) callback,
      [FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    _noteDal.addListener(callback, querie);
  }

  @override
  void removeListener() {
    _noteDal.removeListener();
  }
}