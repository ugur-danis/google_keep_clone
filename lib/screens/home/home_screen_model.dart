part of 'home_screen.dart';

mixin _HomeScreenMixin on State<HomeScreen> {
  late final IFirebaseNoteManager _noteManager;
  late final IFirebaseArchiveManager _archiveManager;
  late final StreamController _streamController;
  late final List<Note> _selectedNotes;
  int _gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();

    _noteManager = locator<IFirebaseNoteManager>();
    _noteManager.addListener(_handleNotesChange);
    _archiveManager = locator<IFirebaseArchiveManager>();
    _streamController = StreamController();
    _selectedNotes = [];

    fetchNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _noteManager.removeListener();
    _streamController.close();
  }

  Future<void> fetchNotes() async {
    try {
      await _noteManager.getAll();
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

  void focusClear() => FocusScope.of(context).unfocus();

  void archiveNotes() {}

  void deleteNote() {}

  void createNoteCopy() async {
    final Note note = _selectedNotes.first;
    note.id = null;
    await _noteManager.add(note);
    clearSelectedNotes();
  }

  void navToSearchScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SearchNoteScreen()));
  }

  void navToEditNoteScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const EditNoteScreen()));
  }

  void toggleGridCrossAxisCount() {
    setState(() {
      _gridCrossAxisCount = _gridCrossAxisCount == 2 ? 1 : 2;
    });
  }

  void notifyNoteDeleted(List<Note> deletedNotes) {}

  void notifyNoteArchived(List<Note> archivedNotes) {}

  void _handleNotesChange(List<Note> notes) => _streamController.add(notes);
}
