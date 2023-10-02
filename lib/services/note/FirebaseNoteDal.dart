// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import '../../models/Note.dart';
import '../../utils/types/Query.dart';
import 'interfaces/IFirebaseNoteDal.dart';

class FirebaseNoteDal implements IFirebaseNoteDal {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listener;

  @override
  Future<Note?> get([FetchQuery? querie]) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection('notes').doc(querie?['id']).get();

    final Map<String, dynamic>? item = doc.data();
    if (item == null) return null;

    return Note.fromMap(item);
  }

  @override
  Future<List<Note>> getAll([FetchQuery? querie]) async {
    final List<Note> notes = <Note>[];

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('notes')
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
          _firestore.collection('notes').doc();
      note.id = ref.id;
      await ref.set(note.toMap());
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  Future<void> delete(Note entity) async {
    try {
      await _firestore.collection('notes').doc(entity.id).delete();
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  Future<void> update(Note note) async {
    try {
      note.lastEditDate = DateTime.now();
      await _firestore.collection('notes').doc(note.id).update(note.toMap());
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  void addListener(Function(List<Note>) callback, [FetchQuery? querie]) {
    removeListener();

    final Query<Map<String, dynamic>> snapshot = _firestore
        .collection('notes')
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
