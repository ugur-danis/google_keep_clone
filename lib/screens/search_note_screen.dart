import 'package:flutter/material.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  final FocusNode _inputNode = FocusNode();
  // declear a focusNode object

  @override
  void initState() {
    super.initState();
    _inputNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: SearchBar(
            focusNode: _inputNode,
            hintText: 'Notlarınızda arayın',
          ),
        ),
        body: notFound(context),
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
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
