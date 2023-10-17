// ignore_for_file: file_names

import '../../../models/Note.dart';
import '../../interfaces/IFirebaseEntityRepository.dart';
import 'IRecycleBinDal.dart';

abstract class IFirebaseRecycleBinDal extends IRecycleBinDal
    implements IFirebaseEntityRepository<Note> {}
