// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import 'interfaces/IFirebaseNoteDal.dart';
import '../models/Note.dart';

class FirebaseNoteDal implements IFirebaseNoteDal {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Note?> get() async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection('notes').doc().get();

    final Map<String, dynamic>? item = doc.data();
    if (item == null) return null;

    return Note.fromMap(item);
  }

  @override
  Future<List<Note>> getAll() async {
    final List<Note> notes = <Note>[];

    try {
      final CollectionReference<Map<String, dynamic>> ref =
          _firestore.collection('notes');

      final QuerySnapshot<Map<String, dynamic>> querySnap = await ref.get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnap.docs) {
        Map<String, dynamic> item = doc.data();
        item['id'] = doc.id;
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
  void addListener(Function(List<Note>) callback) {
    final CollectionReference<Map<String, dynamic>> ref =
        _firestore.collection('notes');

    ref.snapshots().listen(
      (event) {
        final List<Note> notes = event.docs.map((doc) {
          final item = doc.data();
          item['id'] = doc.id;
          return Note.fromMap(item);
        }).toList();

        callback!(notes);
      },
    );
  }
}
