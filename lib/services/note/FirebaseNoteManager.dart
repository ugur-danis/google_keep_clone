// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/fetch_query.dart';
import '../../utils/types/add_listener_callback.dart';
import '../archive/interfaces/IFirebaseArchiveDal.dart';
import '../trash/interfaces/IFirebaseTrashDal.dart';
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
    note.lastEditDate = DateTime.now();
    _noteDal.add(note);
  }

  @override
  Future<void> delete(Note note) async {
    _noteDal.delete(note);
  }

  @override
  Future<void> moveToTrash(Note note) async {
    note.lastEditDate = DateTime.now();
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
    note.lastEditDate = DateTime.now();
    _noteDal.add(note);
    _trashDal.delete(note);
  }

  @override
  Future<Note?> get([FetchQuery? query]) async {
    User? user = await _userDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    query ??= FetchQuery(
      field: 'userId',
      value: user.id!,
      operation: FetchQueryOperation.isEqualTo,
    );

    return _noteDal.get(query);
  }

  @override
  Future<List<Note>> getAll([FetchQuery? query]) async {
    User? user = await _userDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    query ??= FetchQuery(
      field: 'userId',
      value: user.id!,
      operation: FetchQueryOperation.isEqualTo,
    );

    return _noteDal.getAll(query);
  }

  @override
  Future<void> update(Note note) async {
    note.lastEditDate = DateTime.now();
    _noteDal.update(note);
  }

  @override
  void addListener(AddListenerCallback<Note> callback,
      [FetchQuery? query]) async {
    User? user = await _userDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    query ??= FetchQuery(
      field: 'userId',
      value: user.id!,
      operation: FetchQueryOperation.isEqualTo,
    );

    _noteDal.addListener(callback, query);
  }

  @override
  void removeListener() {
    _noteDal.removeListener();
  }
}
