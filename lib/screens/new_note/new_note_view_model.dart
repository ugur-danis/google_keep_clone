part of 'new_note_screen.dart';

mixin _NewNoteScreenMixin on State<NewNoteScreen> {
  late final Note _note;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isNewNote) {
      _note = Note(title: '', note: '', lastEditDate: DateTime.now());
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
    context.read<NoteProvider>().deleteNote(_note);
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  Future<bool> onWillPop() {
    if (_note.note!.isEmpty && _note.title!.isEmpty) {
      context.read<NoteProvider>().deleteNote(_note);
    }

    return Future.value(true);
  }
}
