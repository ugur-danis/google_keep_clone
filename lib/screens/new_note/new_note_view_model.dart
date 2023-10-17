part of 'new_note_screen.dart';

mixin _NewNoteScreenMixin on State<NewNoteScreen> {
  late final IFirebaseNoteManager _noteManager;
  late final IFirebaseRecycleBinManager _recycleBinManager;
  late final Note _note;

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _noteManager = locator<IFirebaseNoteManager>();
    _recycleBinManager = locator<IFirebaseRecycleBinManager>();

    if (widget.note == null) {
      _handleNewNote();
    } else {
      _note = widget.note!.copyWith();
    }

    _initController();
  }

  void _handleNewNote() {
    _note = Note(
      userId: context.read<AuthProvider>().user?.id,
      title: '',
      note: '',
      lastEditDate: DateTime.now(),
    );

    _noteManager.add(_note);
  }

  void _initController() {
    _titleEditingController.text = _note.title!;
    _noteEditingController.text = _note.note!;

    _titleEditingController.addListener(() {
      setState(() {
        _note.title = _titleEditingController.text;
      });
      _noteManager.update(_note);
    });

    _noteEditingController.addListener(() {
      setState(() {
        _note.note = _noteEditingController.text;
      });
      _noteManager.update(_note);
    });
  }

  void deleteNote() {
    Navigator.popUntil(context, (route) => route.isFirst);
    _noteManager.moveToRecycleBin(_note);
    notifyNoteDeleted();
  }

  void restoreNoteAndGoHomeScreen() {
    _noteManager.restore(_note);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void notifyNoteDeleted() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 6),
        content: const Text('Note is deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            _noteManager.restore(_note);
          },
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (_note.note!.isEmpty && _note.title!.isEmpty) {
      _noteManager.moveToRecycleBin(_note);
    }

    return Future.value(true);
  }
}
