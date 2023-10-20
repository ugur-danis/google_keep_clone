// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/types/FetchQuery.dart';
import '../auth/interfaces/IFirebaseAuthDal.dart';
import '../note/interfaces/INoteDal.dart';
import 'interfaces/IFirebaseTrashDal.dart';
import 'interfaces/IFirebaseTrashManager.dart';

class FirebaseTrashManager implements IFirebaseTrashManager {
  final IFirebaseTrashDal _trashDal;
  final IFirebaseAuthDal _authDal;
  final INoteDal _noteDal;

  FirebaseTrashManager({
    required IFirebaseTrashDal trashDal,
    required IFirebaseAuthDal authDal,
    required INoteDal noteDal,
  })  : _trashDal = trashDal,
        _authDal = authDal,
        _noteDal = noteDal;

  @override
  Future<List<Note>> getAll([FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    return _trashDal.getAll(querie);
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
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    _trashDal.addListener(callback, querie);
  }

  @override
  void removeListener() {
    _trashDal.removeListener();
  }
}