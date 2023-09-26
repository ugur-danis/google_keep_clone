// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../interfaces/IFirebaseEntityRepository.dart';
import 'INoteDal.dart';

abstract class IFirebaseNoteDal extends INoteDal
    implements IFirebaseEntityRepository<Note> {}
