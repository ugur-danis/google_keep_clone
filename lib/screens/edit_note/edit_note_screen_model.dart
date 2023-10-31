part of 'edit_note_screen.dart';

mixin _EditNoteScreenMixin on State<EditNoteScreen> {
  late final IFirebaseNoteManager _noteManager;
  late final IFirebaseTrashManager _trashManager;
  late final IFirebaseArchiveManager _archiveManager;
  late final Note _note;

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _noteManager = locator<IFirebaseNoteManager>();
    _trashManager = locator<IFirebaseTrashManager>();
    _archiveManager = locator<IFirebaseArchiveManager>();

    if (widget.note == null) {
      _handleNewNote();
    } else {
      _note = widget.note!.copyWith();
    }

    if (_note.color != null) {
      setSystemColorByNoteColor();
    }

    _initController();
  }

  void _handleNewNote() {
    _note = Note(
      userId: context.read<UserProvider>().user?.id,
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
    _noteManager.moveToTrash(_note);
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

  void onChangeNoteColor(Color? color) {
    setState(() {
      _note.color = color?.value;
    });

    _noteManager.update(_note);
    if (color != null) {
      setSystemColorByNoteColor();
    } else {
      clearSystemColor();
    }
  }

  void setSystemColorByNoteColor() {
    Color color = Color(_note.color!);

    SystemUITheme.setStatusAndNavBar(
      statusBarColor: color,
      navBarColor: color,
      navBarDividerColor: color,
    );
  }

  void clearSystemColor() {
    context.read<ThemeProvider>().getAppTheme.setDefaultSystemUIOverlayStyle();
  }

  void createNoteCopy() async {
    final Note note = _note.copyWith();
    note.id = null;
    note.pinned = false;

    Navigator.of(context).pop();
    await _noteManager.add(note);
    navToEditNoteScreen(note);
  }

  void navToEditNoteScreen(Note note) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EditNoteScreen(note: note)));
  }

  void updateNotePinned() {
    setState(() {
      _note.pinned = !_note.pinned;
    });
    _noteManager.update(_note);
  }

  void archiveNotes() {
    Navigator.of(context).pop();
    _noteManager.moveToArchive(_note);
    notifyNoteArchived(true);
  }

  void unarchiveNote() {
    _archiveManager.restore(_note);
    notifyNoteArchived(false);
    navToEditNoteScreen(_note);
  }

  void notifyNoteArchived(bool isArchived) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 6),
        content: Text(isArchived ? 'Note archived' : 'Note unarchived'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            if (isArchived) {
              _archiveManager.restore(_note);
            } else {
              _noteManager.moveToArchive(_note);
            }
          },
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    clearSystemColor();

    if (_note.note!.isEmpty && _note.title!.isEmpty) {
      _noteManager.moveToTrash(_note);
    }

    return Future.value(true);
  }
}
