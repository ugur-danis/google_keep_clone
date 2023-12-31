// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/fetch_query.dart';
import '../../utils/types/add_listener_callback.dart';
import '../note/interfaces/INoteDal.dart';
import '../user/interfaces/IFirebaseUserDal.dart';
import 'interfaces/IFirebaseTrashDal.dart';
import 'interfaces/IFirebaseTrashManager.dart';

class FirebaseTrashManager implements IFirebaseTrashManager {
  final IFirebaseTrashDal _trashDal;
  final IFirebaseUserDal _userDal;
  final INoteDal _noteDal;

  FirebaseTrashManager({
    required IFirebaseTrashDal trashDal,
    required IFirebaseUserDal userDal,
    required INoteDal noteDal,
  })  : _trashDal = trashDal,
        _userDal = userDal,
        _noteDal = noteDal;

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

    return _trashDal.getAll(query);
  }

  @override
  Future<void> restore(Note note) async {
    await _noteDal.add(note);
    await _trashDal.delete(note);
  }

  @override
  Future<void> delete(Note note) async {
    _trashDal.delete(note);
  }

  @override
  Future<void> allDelete() async {
    final List<Note> notes = await getAll();
    Future.forEach(notes, (note) async => await _trashDal.delete(note));
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

    _trashDal.addListener(callback, query);
  }

  @override
  void removeListener() {
    _trashDal.removeListener();
  }
}
