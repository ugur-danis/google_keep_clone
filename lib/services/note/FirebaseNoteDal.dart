// ignore_for_file: file_names

import '../../models/Note.dart';
import '../concrete/BaseFirebaseEntityRepository.dart';
import 'interfaces/IFirebaseNoteDal.dart';

class FirebaseNoteDal extends BaseFirebaseEntityRepository<Note>
    implements IFirebaseNoteDal {
  FirebaseNoteDal()
      : super(
          model: Note(),
          collections: FirestoreCollections.notes,
        );
}
