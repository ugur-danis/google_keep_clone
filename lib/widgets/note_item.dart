import 'package:flutter/material.dart';

import '../screens/edit_note/edit_note_screen.dart';
import '../models/Note.dart';

class _SearchResult {
  _SearchResult({
    required this.startIndex,
    required this.endIndex,
    required this.lastIndex,
  });

  final int startIndex;
  final int endIndex;
  final int lastIndex;
}

// ignore: must_be_immutable
class NoteItem extends StatelessWidget {
  NoteItem({
    super.key,
    required this.note,
    this.isEditable = true,
    this.isArchived = false,
    this.selected = false,
    this.onSelected,
    this.searchText = '',
  });

  final Note note;
  final bool isEditable;
  final bool isArchived;
  final ValueSetter<bool>? onSelected;
  bool selected;
  bool _isTapped = false;
  String searchText;

  // ignore: library_private_types_in_public_api
  _SearchResult findMatchingIndices({required String text, start = 0}) {
    final String lowerCaseText = text.toLowerCase();
    final String lowerCaseSearchText = searchText.toLowerCase();

    int startIndex = lowerCaseText.indexOf(lowerCaseSearchText, start);
    int endIndex = startIndex == -1 ? -1 : startIndex + searchText.length;
    int lastIndex = lowerCaseText.lastIndexOf(lowerCaseSearchText);

    return _SearchResult(
      startIndex: startIndex,
      endIndex: endIndex,
      lastIndex: lastIndex,
    );
  }

  List<TextSpan> highlightMatches(String text) {
    final List<TextSpan> textSpanList =
        text.characters.map((c) => TextSpan(text: c)).toList();

    if (searchText.isEmpty) {
      return textSpanList;
    }

    int lastIndex = findMatchingIndices(text: text).lastIndex;
    int startToSearch = 0;

    while (startToSearch <= lastIndex) {
      final _SearchResult searchResult = findMatchingIndices(
        text: text,
        start: startToSearch,
      );

      if (searchResult.startIndex == -1) {
        return textSpanList;
      }

      startToSearch = searchResult.endIndex;

      for (int i = searchResult.startIndex; i < searchResult.endIndex; i++) {
        textSpanList[i] = _HighlightedTextSpan(text: textSpanList[i].text);
      }
    }

    return textSpanList;
  }

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
              buildNoteTitle(context),
              buildNoteContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNoteContent(BuildContext context) {
    return Expanded(
      child: RichText(
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: highlightMatches(note.note!),
        ),
      ),
    );
  }

  Padding buildNoteTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: highlightMatches(note.title!),
        ),
      ),
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
              isArchived: isArchived,
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

class _HighlightedTextSpan extends TextSpan {
  const _HighlightedTextSpan({super.text})
      : super(
          style: const TextStyle(
            backgroundColor: Colors.amber,
          ),
        );
}
