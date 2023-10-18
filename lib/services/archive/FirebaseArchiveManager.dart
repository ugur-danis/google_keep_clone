// ignore_for_file: file_names

import '../../models/Note.dart';
import '../../models/User.dart';
import '../../utils/types/FetchQuery.dart';
import '../auth/interfaces/IFirebaseAuthDal.dart';
import '../note/interfaces/IFirebaseNoteDal.dart';
import '../recycle_bin/interfaces/IFirebaseRecycleBinDal.dart';
import 'interfaces/IFirebaseArchiveDal.dart';
import 'interfaces/IFirebaseArchiveManager.dart';

class FirebaseArchiveManager implements IFirebaseArchiveManager {
  final IFirebaseArchiveDal _archiveDal;
  final IFirebaseAuthDal _authDal;
  final IFirebaseNoteDal _noteDal;
  final IFirebaseRecycleBinDal _recycleBinDal;

  FirebaseArchiveManager({
    required IFirebaseArchiveDal archiveDal,
    required IFirebaseAuthDal authDal,
    required IFirebaseNoteDal noteDal,
    required IFirebaseRecycleBinDal recycleBinDal,
  })  : _archiveDal = archiveDal,
        _authDal = authDal,
        _noteDal = noteDal,
        _recycleBinDal = recycleBinDal;

  @override
  Future<List<Note>> getAll([FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    return _archiveDal.getAll(querie);
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
  Future<void> moveToRecycleBin(Note note) async {
    _recycleBinDal.add(note);
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
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]) async {
    User? user = await _authDal.getUser();
    if (user == null) {
      throw Exception('User not found');
    }

    querie ??= {};
    querie['userId'] = user.id;

    _archiveDal.addListener(callback, querie);
  }

  @override
  void removeListener() {
    _archiveDal.removeListener();
  }
}
