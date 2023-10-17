import 'package:flutter/material.dart';

import '../screens/new_note/new_note_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: selected
              ? Colors.lightBlueAccent
              : Theme.of(context).colorScheme.outline,
          width: selected ? 3 : .5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onLongPress: () {
          selected = true;
          onSelected?.call(true);
        },
        onTap: () {
          if (selected) {
            selected = false;
            onSelected?.call(false);
            return;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewNoteScreen(
                  note: note,
                  isEditable: isEditable,
                ),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(note.title!),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(note.note!,
                    maxLines: 6, overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
