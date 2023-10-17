// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../interfaces/IFirebaseEntityRepository.dart';
import 'IArchiveDal.dart';

abstract class IFirebaseArchiveDal extends IArchiveDal
    implements IFirebaseEntityRepository<Note> {}
