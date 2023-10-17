// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/types/FetchQuery.dart';
import '../auth/interfaces/IFirebaseAuthDal.dart';
import '../note/interfaces/INoteDal.dart';
import 'interfaces/IFirebaseRecycleBinDal.dart';
import 'interfaces/IFirebaseRecycleBinManager.dart';

class FirebaseRecycleBinManager implements IFirebaseRecycleBinManager {
  final IFirebaseRecycleBinDal _recycleBinDal;
  final IFirebaseAuthDal _authDal;
  final INoteDal _noteDal;

  FirebaseRecycleBinManager({
    required IFirebaseRecycleBinDal recycleBinDal,
    required IFirebaseAuthDal authDal,
    required INoteDal noteDal,
  })  : _recycleBinDal = recycleBinDal,
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

    return _recycleBinDal.getAll(querie);
  }

  @override
  Future<void> restore(Note note) async {
    await _noteDal.add(note);
    await _recycleBinDal.delete(note);
  }

  @override
  Future<void> delete(Note note) async {
    _recycleBinDal.delete(note);
  }

  @override
  Future<void> allDelete() async {
    final List<Note> notes = await getAll();
    Future.forEach(notes, (note) async => await _recycleBinDal.delete(note));
  }

  @override
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    _recycleBinDal.addListener(callback, querie);
  }

  @override
  void removeListener() {
    _recycleBinDal.removeListener();
  }
}
