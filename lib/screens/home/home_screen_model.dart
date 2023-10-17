part of 'home_screen.dart';

mixin _HomeScreenMixin on State<HomeScreen> {
  late final IFirebaseNoteManager _noteManager;
  late final StreamController _streamController;
  int _gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();

    _noteManager = locator<IFirebaseNoteManager>();
    _noteManager.addListener(_handleNotesChange);
    _streamController = StreamController();

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

  void focusClear() => FocusScope.of(context).unfocus();

  void navToSearchScreen() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SearchNoteScreen()));

  void navToNewNoteScreen() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const EditNoteScreen()));

  void toggleGridCrossAxisCount() => setState(() {
        _gridCrossAxisCount = _gridCrossAxisCount == 2 ? 1 : 2;
      });

  void _handleNotesChange(List<Note> notes) => _streamController.add(notes);
}
