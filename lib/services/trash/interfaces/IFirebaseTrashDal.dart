// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../interfaces/IFirebaseEntityRepository.dart';
import 'ITrashDal.dart';

abstract class IFirebaseTrashDal extends ITrashDal
    implements IFirebaseEntityRepository<Note> {}
