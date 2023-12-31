part of 'archive_screen.dart';

mixin _ArchiveScreenMixin on State<ArchiveScreen> {
  late final IFirebaseArchiveManager _archiveManager;
  late final IFirebaseNoteManager _noteManager;
  late final StreamController _streamController;
  late final List<Note> _selectedNotes;
  int _gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    _archiveManager = locator<IFirebaseArchiveManager>();
    _archiveManager.addListener(_handleNotesChange);
    _noteManager = locator<IFirebaseNoteManager>();
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

  void unarchiveNote() {
    for (var note in _selectedNotes) {
      _archiveManager.restore(note);
    }

    clearSelectedNotes();
  }

  void deleteNote() {
    for (var note in _selectedNotes) {
      _archiveManager.moveToTrash(note);
    }

    clearSelectedNotes();
  }

  void createNoteCopy() async {
    final Note note = _selectedNotes.first;
    note.id = null;
    await _noteManager.add(note);
    clearSelectedNotes();
  }

  void updateNotePinned() {
    for (var note in _selectedNotes) {
      note.pinned = true;
      _archiveManager.restore(note);
      _noteManager.update(note);
    }

    clearSelectedNotes();
  }

  void toggleGridCrossAxisCount() {
    setState(() {
      _gridCrossAxisCount = _gridCrossAxisCount == 2 ? 1 : 2;
    });
  }

  void navToSearchScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SearchNoteScreen()));
  }

  void _handleNotesChange(List<Note> notes) => _streamController.add(notes);
}
