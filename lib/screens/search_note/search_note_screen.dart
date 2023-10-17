library search_note;

import 'package:flutter/material.dart';

part 'search_note_view_model.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen>
    with _SearchNoteScreenMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusClear,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: SearchBar(
              focusNode: _inputNode,
              hintText: 'Notlarınızda arayın',
            ),
          ),
          body: notFound(context),
        ),
      ),
    );
  }

  Widget notFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 120,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Eşleşen not yok',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
