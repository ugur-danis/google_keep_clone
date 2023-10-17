// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:developer' as developer;

import '../../models/Note.dart';
import '../../utils/types/FetchQuery.dart';
import 'interfaces/IFirebaseRecycleBinDal.dart';

class FirebaseRecycleBinDal implements IFirebaseRecycleBinDal {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listener;

  @override
  Future<Note?> get([FetchQuery? querie]) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getAll([FetchQuery? querie]) async {
    final List<Note> notes = <Note>[];

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('recycle_bin')
          .where(
            'userId',
            isEqualTo: querie?['userId'],
          )
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        Map<String, dynamic> item = doc.data();
        notes.add(Note.fromMap(item));
      }
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }

    return notes;
  }

  @override
  Future<void> add(Note note) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref =
          _firestore.collection('recycle_bin').doc(note.id);
      await ref.set(note.toMap());
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  Future<void> delete(Note note) async {
    try {
      await _firestore.collection('recycle_bin').doc(note.id).delete();
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  Future<void> update(Note entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]) {
    removeListener();

    final Query<Map<String, dynamic>> snapshot = _firestore
        .collection('recycle_bin')
        .where('userId', isEqualTo: querie?['userId']);

    _listener = snapshot.snapshots().listen(
      (event) {
        final List<Note> notes = event.docs.map((doc) {
          final item = doc.data();
          return Note.fromMap(item);
        }).toList();

        callback(notes);
      },
    );
  }

  @override
  void removeListener() {
    if (_listener != null) {
      _listener!.cancel();
    }
  }
}
