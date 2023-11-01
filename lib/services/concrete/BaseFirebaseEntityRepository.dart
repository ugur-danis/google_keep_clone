// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_keep_clone/services/interfaces/IFirebaseEntityRepository.dart';

import '../../utils/types/FetchQuery.dart';
import '../../utils/types/add_listener_callback.dart';
import '../interfaces/IEntity.dart';

enum FirestoreCollections {
  notes,
  archive,
  trash;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}

class BaseFirebaseEntityRepository<T extends IEntity>
    implements IFirebaseEntityRepository<T> {
  BaseFirebaseEntityRepository({
    required this.model,
    required this.collections,
  });

  final IEntity model;
  final FirestoreCollections collections;

  StreamSubscription<QuerySnapshot<T>>? listener;

  @override
  Future<T?> get([FetchQuery? query]) async {
    final ref = collections.reference;

    final response = await ref
        .withConverter<T>(
          fromFirestore: (snapshot, _) => model.fromFirebase(snapshot),
          toFirestore: (value, _) => value.toMap(),
        )
        .doc(query?['id'])
        .get();

    return response.data();
  }

  @override
  Future<List<T>> getAll([FetchQuery? query]) async {
    final ref = collections.reference;

    final response = await ref
        .withConverter<T>(
          fromFirestore: (snapshot, _) => model.fromFirebase(snapshot),
          toFirestore: (value, _) => value.toMap(),
        )
        .get();

    return response.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> add(IEntity entity) async {
    try {
      final ref = collections.reference.doc(entity.id);

      entity.id = ref.id;
      await ref.set(entity.toMap());
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  Future<void> delete(IEntity entity) async {
    try {
      await collections.reference.doc(entity.id).delete();
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  Future<void> update(IEntity entity) async {
    try {
      await collections.reference.doc(entity.id).update(entity.toMap());
    } catch (e) {
      developer.log('\x1B[31m$e\x1B[0m');
    }
  }

  @override
  void addListener(AddListenerCallback<T> callback, [FetchQuery? querie]) {
    removeListener();

    final snapshot = collections.reference
        .withConverter<T>(
          fromFirestore: (snapshot, _) => model.fromFirebase(snapshot),
          toFirestore: (value, _) => value.toMap(),
        )
        .where('userId', isEqualTo: querie?['userId']);

    listener = snapshot.snapshots().listen(
      (event) {
        final entities = event.docs.map((doc) => doc.data()).toList();
        callback(entities);
      },
    );
  }

  @override
  void removeListener() {
    listener?.cancel();
  }
}
