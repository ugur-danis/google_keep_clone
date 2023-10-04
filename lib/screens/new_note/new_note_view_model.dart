part of 'new_note_screen.dart';

mixin _NewNoteScreenMixin on State<NewNoteScreen> {
  late final Note _note;
  Function? _deletedNoteDelegate;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isNewNote) {
      _note = Note(
        userId: context.read<AuthProvider>().user?.id,
        title: '',
        note: '',
        lastEditDate: DateTime.now(),
      );
      Future.delayed(const Duration(seconds: 1), () {
        context.read<NoteProvider>().addNote(_note);
      });
    } else {
      _note = context
          .read<NoteProvider>()
          .notes
          .singleWhere((element) => element.id == widget.noteId);
    }

    _titleEditingController.text = _note.title!;
    _noteEditingController.text = _note.note!;

    _titleEditingController.addListener(() {
      setState(() {
        _note.title = _titleEditingController.text;
      });
      context.read<NoteProvider>().updateNote(_note);
    });

    _noteEditingController.addListener(() {
      setState(() {
        _note.note = _noteEditingController.text;
      });
      context.read<NoteProvider>().updateNote(_note);
    });
  }

  void deleteNote() {
    _deletedNoteDelegate =
        context.read<NoteProvider>().deleteNoteDelayed(_note);
    notifyNoteDeleted();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void notifyNoteDeleted() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 6),
        content: const Text('Note is deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => _deletedNoteDelegate!(),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (_note.note!.isEmpty && _note.title!.isEmpty) {
      context.read<NoteProvider>().deleteNote(_note);
    }

    return Future.value(true);
  }
}
