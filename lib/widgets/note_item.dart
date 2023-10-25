import 'package:flutter/material.dart';

import '../screens/edit_note/edit_note_screen.dart';
import '../models/Note.dart';

// ignore: must_be_immutable
class NoteItem extends StatelessWidget {
  NoteItem({
    super.key,
    required this.note,
    this.isEditable = true,
    this.onSelected,
    this.selected = false,
  });

  final Note note;
  final bool isEditable;
  final ValueSetter<bool>? onSelected;
  bool selected;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      color: note.color == null ? Colors.transparent : Color(note.color!),
      shape: buildShape(context),
      child: InkWell(
        onLongPress: onLongPress,
        onTap: () => onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNoteTitle(),
              buildNoteContent(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildNoteContent() {
    return Expanded(
      child: Text(note.note!, maxLines: 6, overflow: TextOverflow.ellipsis),
    );
  }

  Padding buildNoteTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(note.title!),
    );
  }

  void onTap(BuildContext context) {
    if (_isTapped) return;

    if (selected) {
      selected = false;
      onSelected?.call(false);
      return;
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNoteScreen(
              note: note,
              isEditable: isEditable,
            ),
          ));
      _isTapped = false;
    });

    _isTapped = true;
  }

  void onLongPress() {
    selected = true;
    onSelected?.call(true);
  }

  RoundedRectangleBorder? buildShape(BuildContext context) {
    if (!selected && note.color != null) {
      return null;
    }

    return RoundedRectangleBorder(
      side: BorderSide(
        width: selected ? 3 : 1,
        color: selected
            ? Colors.lightBlueAccent
            : Theme.of(context).colorScheme.outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    );
  }
}
