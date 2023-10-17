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

    _noteManager = locator.get<IFirebaseNoteManager>();
    _recycleBinManager = locator.get<IFirebaseRecycleBinManager>();

    if (widget.note == null) {
      _handleNewNote();
    } else {
      _note = widget.note!.copyWith();
    }

    initController();
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

  void initController() {
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

  void showNoteDeletionConfirmDialog() {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget continueButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        _recycleBinManager.delete(_note);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RecycleBinScreen(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Permanently delete note?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => alert,
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
