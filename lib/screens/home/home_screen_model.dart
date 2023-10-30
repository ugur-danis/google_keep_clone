part of 'home_screen.dart';

mixin _HomeScreenMixin on State<HomeScreen>, RouteAware {
  late final IFirebaseNoteManager _noteManager;
  late final IFirebaseArchiveManager _archiveManager;
  late final StreamController<List<Note>> _streamController;
  late final List<Note> _selectedNotes;
  int _gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();

    _noteManager = locator<IFirebaseNoteManager>();
    _noteManager.addListener(_handleNotesChange);
    _archiveManager = locator<IFirebaseArchiveManager>();
    _streamController = StreamController<List<Note>>.broadcast();
    _selectedNotes = [];

    setSystemUITheme();
    fetchNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _noteManager.removeListener();
    _streamController.close();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPop();
    setSystemUITheme();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    context.read<ThemeProvider>().getAppTheme.setDefaultSystemUIOverlayStyle();
  }

  void setSystemUITheme() {
    ThemeData theme = context.read<ThemeProvider>().getTheme;
    SystemUITheme.setStatusAndNavBar(
      navBarColor: theme.bottomAppBarTheme.color,
      navBarDividerColor: theme.bottomAppBarTheme.color,
      statusBarColor: theme.scaffoldBackgroundColor,
    );
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

  void archiveNotes() {
    for (var note in _selectedNotes) {
      _noteManager.moveToArchive(note);
    }

    notifyNoteArchived(List.from(_selectedNotes));
    clearSelectedNotes();
  }

  void deleteNote() {
    for (var note in _selectedNotes) {
      _noteManager.moveToTrash(note);
    }

    notifyNoteDeleted(List.from(_selectedNotes));
    clearSelectedNotes();
  }

  void createNoteCopy() async {
    final Note note = _selectedNotes.first.copyWith();
    note.id = null;
    note.pinned = false;

    await _noteManager.add(note);
    clearSelectedNotes();
  }

  void updateNotePinned() {
    final bool pinned = _selectedNotes.any((n) => n.pinned == false);

    for (var note in _selectedNotes) {
      note.pinned = pinned;
      _noteManager.update(note);
    }

    clearSelectedNotes();
  }

  List<Note> filterNotesByPinned(List<Note> notes, bool pinned) {
    return notes.where((n) => n.pinned == pinned).toList();
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

  void notifyNoteDeleted(List<Note> deletedNotes) {
    const String singleItemText = 'Note moved to trash';
    const String multiItemText = 'Notes moved to trash';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 6),
        content: Text(deletedNotes.length > 1 ? multiItemText : singleItemText),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            for (var note in deletedNotes) {
              _noteManager.restore(note);
            }
          },
        ),
      ),
    );
  }

  void notifyNoteArchived(List<Note> archivedNotes) {
    const String singleItemText = 'Note archived';
    const String multiItemText = 'Notes archived';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 6),
        content:
            Text(archivedNotes.length > 1 ? multiItemText : singleItemText),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            for (var note in archivedNotes) {
              _archiveManager.restore(note);
            }
          },
        ),
      ),
    );
  }

  void focusClear() => FocusScope.of(context).unfocus();

  void _handleNotesChange(List<Note> notes) => _streamController.add(notes);
}
