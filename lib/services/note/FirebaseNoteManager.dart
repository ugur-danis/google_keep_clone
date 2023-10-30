// ignore_for_file: file_names

import 'package:google_keep_clone/services/trash/interfaces/IFirebaseTrashDal.dart';

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/types/FetchQuery.dart';
import '../archive/interfaces/IFirebaseArchiveDal.dart';
import '../user/interfaces/IFirebaseUserDal.dart';
import 'interfaces/IFirebaseNoteDal.dart';
import 'interfaces/IFirebaseNoteManager.dart';

class FirebaseNoteManager implements IFirebaseNoteManager {
  final IFirebaseNoteDal _noteDal;
  final IFirebaseTrashDal _trashDal;
  final IFirebaseUserDal _userDal;
  final IFirebaseArchiveDal _archiveDal;

  FirebaseNoteManager({
    required IFirebaseNoteDal noteDal,
    required IFirebaseTrashDal trashDal,
    required IFirebaseUserDal userDal,
    required IFirebaseArchiveDal archiveDal,
  })  : _noteDal = noteDal,
        _trashDal = trashDal,
        _userDal = userDal,
        _archiveDal = archiveDal;

  @override
  Future<void> add(Note note) async {
    _noteDal.add(note);
  }

  @override
  Future<void> delete(Note note) async {
    _noteDal.delete(note);
  }

  @override
  Future<void> moveToTrash(Note note) async {
    _noteDal.delete(note);
    _trashDal.add(note);
  }

  @override
  Future<void> moveToArchive(Note note) async {
    _noteDal.delete(note);
    _archiveDal.add(note);
  }

  @override
  Future<void> restore(Note note) async {
    _noteDal.add(note);
    _trashDal.delete(note);
  }

  @override
  Future<Note?> get([FetchQuery? querie]) async {
    User? user = await _userDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    return _noteDal.get(querie);
  }

  @override
  Future<List<Note>> getAll([FetchQuery? querie]) async {
    User? user = await _userDal.getUser();
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
    User? user = await _userDal.getUser();
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
