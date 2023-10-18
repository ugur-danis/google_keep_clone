part of 'archive_screen.dart';

mixin _ArchiveScreenMixin on State<ArchiveScreen> {
  late final IFirebaseArchiveManager _archiveManager;
  late final StreamController _streamController;
  late final List<Note> _selectedNotes;
  int _gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    _archiveManager = locator<IFirebaseArchiveManager>();
    _archiveManager.addListener(_handleNotesChange);
    _streamController = StreamController();
    _selectedNotes = [];

    fetchNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _archiveManager.removeListener();
    _streamController.close();
  }

  Future<void> fetchNotes() async {
    try {
      await _archiveManager.getAll();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void onChangeSelectedNotes(Note note, bool isSelected) {
    setState(() {
      if (isSelected && !_selectedNotes.contains(note)) {
        _selectedNotes.add(note);
      } else {
        _selectedNotes.remove(note);
      }
    });
  }

  void clearSelectedNotes() {
    setState(() {
      _selectedNotes.clear();
    });
  }

  void unarchiveNote() {}

  void deleteNote() {}

  void createNoteCopy() async {}

  void toggleGridCrossAxisCount() {}

  void navToSearchScreen() {}

  void _handleNotesChange(List<Note> notes) => _streamController.add(notes);
}
