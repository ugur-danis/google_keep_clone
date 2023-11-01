// ignore_for_file: file_names

import '../../models/Note.dart';
import '../concrete/BaseFirebaseEntityRepository.dart';
import 'interfaces/IFirebaseTrashDal.dart';

class FirebaseTrashDal extends BaseFirebaseEntityRepository<Note>
    implements IFirebaseTrashDal {
  FirebaseTrashDal()
      : super(
          model: Note(),
          collections: FirestoreCollections.trash,
        );
}
