part of 'search_note_screen.dart';

mixin _SearchNoteScreenMixin on State<SearchNoteScreen> {
  late final FocusNode _inputNode;
  late final StreamController<List<Note>> _streamController;
  late final IFirebaseNoteManager _noteManager;
  late final ValueNotifier<String> searchText;

  @override
  void initState() {
    super.initState();
    _inputNode = FocusNode();
    _streamController = StreamController<List<Note>>();
    _noteManager = locator<IFirebaseNoteManager>();
    searchText = ValueNotifier<String>('');

    _inputNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    searchText.dispose();
    _streamController.close();
  }

  Future<void> fetchNotes() async {
    try {
      final FetchQuery titleQuery = FetchQuery(
        field: 'title',
        value: searchText.value,
        operation: FetchQueryOperation.stringContains,
      );
      final FetchQuery noteQuery = titleQuery.copyWith(field: 'note');

      final [res1, res2] = await Future.wait([
        _noteManager.getAll(titleQuery),
        _noteManager.getAll(noteQuery),
      ]);

      final List<Note> notes = (res1 + res2).toSet().toList();
      _streamController.add(notes);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void onChangeSearchText(String? value) {
    searchText.value = value ?? '';
    if (searchText.value.isEmpty) return;

    Future.delayed(const Duration(milliseconds: 300), fetchNotes);
  }

  void focusClear() => FocusScope.of(context).unfocus();
}
