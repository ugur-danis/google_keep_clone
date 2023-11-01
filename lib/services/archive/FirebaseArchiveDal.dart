// ignore_for_file: file_names

import '../../models/Note.dart';
import '../concrete/BaseFirebaseEntityRepository.dart';
import 'interfaces/IFirebaseArchiveDal.dart';

class FirebaseArchiveDal extends BaseFirebaseEntityRepository<Note>
    implements IFirebaseArchiveDal {
  FirebaseArchiveDal()
      : super(
          model: Note(),
          collections: FirestoreCollections.archive,
        );
}
