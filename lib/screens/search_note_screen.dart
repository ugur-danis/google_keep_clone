import 'package:flutter/material.dart';
import 'package:google_keep_clone/constants/color.dart';

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
          backgroundColor: CustomColors.appBarBg,
          title: SearchBar(
            focusNode: _inputNode,
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            hintText: 'Notlarınızda arayın',
            overlayColor: const MaterialStatePropertyAll(CustomColors.appBarBg),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
            textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 14)),
          ),
        ),
        body: notFound(context),
      ),
    );
  }

  Widget notFound(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 120,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Eşleşen not yok',
              style: TextStyle(
                fontSize: 12,
                color: CustomColors.actionsColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
