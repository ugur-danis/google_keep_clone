// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/fetch_query.dart';
import '../../utils/types/add_listener_callback.dart';
import '../note/interfaces/IFirebaseNoteDal.dart';
import '../trash/interfaces/IFirebaseTrashDal.dart';
import '../user/interfaces/IFirebaseUserDal.dart';
import 'interfaces/IFirebaseArchiveDal.dart';
import 'interfaces/IFirebaseArchiveManager.dart';

class FirebaseArchiveManager implements IFirebaseArchiveManager {
  final IFirebaseArchiveDal _archiveDal;
  final IFirebaseUserDal _userDal;
  final IFirebaseNoteDal _noteDal;
  final IFirebaseTrashDal _trashDal;

  FirebaseArchiveManager({
    required IFirebaseArchiveDal archiveDal,
    required IFirebaseUserDal userDal,
    required IFirebaseNoteDal noteDal,
    required IFirebaseTrashDal trashDal,
  })  : _archiveDal = archiveDal,
        _userDal = userDal,
        _noteDal = noteDal,
        _trashDal = trashDal;

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

    return _archiveDal.getAll(query);
  }

  @override
  Future<void> add(Note note) async {
    _archiveDal.add(note);
  }

  @override
  Future<void> restore(Note note) async {
    await _noteDal.add(note);
    await _archiveDal.delete(note);
  }

  @override
  Future<void> moveToTrash(Note note) async {
    _trashDal.add(note);
    _archiveDal.delete(note);
  }

  @override
  Future<void> delete(Note note) async {
    _archiveDal.delete(note);
  }

  @override
  Future<void> allDelete() async {
    final List<Note> notes = await getAll();
    Future.forEach(notes, (note) async => await _archiveDal.delete(note));
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

    _archiveDal.addListener(callback, query);
  }

  @override
  void removeListener() {
    _archiveDal.removeListener();
  }
}
