part of 'recycle_bin_screen.dart';

mixin _RecycleBinScreenMixin on State<RecycleBinScreen> {
  late final IFirebaseRecycleBinManager _recycleBinManager;
  late final StreamController _streamController;
  late final List<Note> _selectedNotes;

  @override
  void initState() {
    super.initState();
    _recycleBinManager = locator<IFirebaseRecycleBinManager>();
    _recycleBinManager.addListener(_handleNotesChange);
    _streamController = StreamController();
    _selectedNotes = [];

    fetchNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _recycleBinManager.removeListener();
    _streamController.close();
  }

  Future<void> fetchNotes() async {
    try {
      await _recycleBinManager.getAll();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  Future<void> deleteAllNotes() async {
    try {
      await _recycleBinManager.allDelete();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  Future<void> deleteSelectedNotes() async {
    for (Note note in _selectedNotes) {
      await _recycleBinManager.delete(note);
    }

    clearSelectedNotes();
  }

  Future<void> restoreSelectedNotes() async {
    for (Note note in _selectedNotes) {
      await _recycleBinManager.restore(note);
    }

    clearSelectedNotes();
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

  void _handleNotesChange(List<Note> notes) => _streamController.add(notes);
}
