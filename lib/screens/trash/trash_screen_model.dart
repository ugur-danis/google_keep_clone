part of 'trash_screen.dart';

mixin _TrashScreenMixin on State<TrashScreen> {
  late final IFirebaseTrashManager _trashManager;
  late final StreamController _streamController;
  late final List<Note> _selectedNotes;

  @override
  void initState() {
    super.initState();
    _trashManager = locator<IFirebaseTrashManager>();
    _trashManager.addListener(_handleNotesChange);
    _streamController = StreamController();
    _selectedNotes = [];

    fetchNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _trashManager.removeListener();
    _streamController.close();
  }

  Future<void> fetchNotes() async {
    try {
      await _trashManager.getAll();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  Future<void> deleteAllNotes() async {
    try {
      await _trashManager.allDelete();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  Future<void> deleteSelectedNotes() async {
    for (Note note in _selectedNotes) {
      await _trashManager.delete(note);
    }

    clearSelectedNotes();
  }

  Future<void> restoreSelectedNotes() async {
    for (Note note in _selectedNotes) {
      await _trashManager.restore(note);
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
