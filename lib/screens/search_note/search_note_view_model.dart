part of 'search_note_screen.dart';

mixin _SearchNoteScreenMixin on State<SearchNoteScreen> {
  final FocusNode _inputNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _inputNode.requestFocus();
  }

  void focusClear() => FocusScope.of(context).unfocus();
}
