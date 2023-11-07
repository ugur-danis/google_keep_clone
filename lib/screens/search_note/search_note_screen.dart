import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/Note.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../utils/fetch_query.dart';
import '../../widgets/illustrated_message.dart';
import '../../widgets/note_item.dart';

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
          body: buildContent(),
        ),
      ),
    );
  }

  Widget buildContent() {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [buildAppBar()],
      body: buildNotesStreamBuilder(),
    );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      title: buildSearchBar(),
    );
  }

  SearchBar buildSearchBar() {
    return SearchBar(
      focusNode: _inputNode,
      hintText: 'Search in your notes',
      onChanged: onChangeSearchText,
    );
  }

  StreamBuilder<List<Note>> buildNotesStreamBuilder() {
    return StreamBuilder<List<Note>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (searchText.value.isEmpty) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return buildErrorMessage(snapshot.error);
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return buildNotMatchingMessage();
          }
          return buildNoteGrid(snapshot.data!);
        }
        return buildProgressIndicator();
      },
    );
  }

  Widget buildNoteGrid(List<Note> notes) {
    return GridView.custom(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: notes.length,
        (context, index) => buildNoteItem(notes[index]),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
    );
  }

  NoteItem buildNoteItem(Note note) {
    return NoteItem(
      note: note,
      searchText: searchText.value,
    );
  }

  Center buildErrorMessage(Object? error) {
    return Center(child: Text(error.toString()));
  }

  Center buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  IllustratedMessage buildNotMatchingMessage() {
    return const IllustratedMessage(
      icon: Icons.search_outlined,
      text: 'No matching notes',
    );
  }
}
