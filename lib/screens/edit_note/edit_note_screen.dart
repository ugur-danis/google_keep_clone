import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../models/Note.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../services/recycle_bin/interfaces/IFirebaseRecycleBinManager.dart';
import '../../utils/formatters/date_formatter.dart';
import '../home/home_screen.dart';
import '../recycle_bin/recycle_bin_screen.dart';

part 'edit_note_screen_model.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    this.note,
    this.isEditable = true,
  });

  final Note? note;
  final bool isEditable;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen>
    with _EditNoteScreenMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: !widget.isEditable
                ? []
                : [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.push_pin_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notification_add_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.archive_outlined),
                    ),
                  ],
          ),
          bottomNavigationBar: buildBottomNavigationBar(context),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _titleEditingController,
                  readOnly: !widget.isEditable,
                  style: Theme.of(context).textTheme.titleLarge!,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Başlık',
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: _noteEditingController,
                  readOnly: !widget.isEditable,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Not',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showNoteDeletionConfirmDialog() {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget continueButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        _recycleBinManager.delete(_note);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RecycleBinScreen(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Permanently delete note?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => alert,
    );
  }

  void showActionList() {
    final List<ListTile> actionList = [];

    if (widget.isEditable) {
      actionList.add(ListTile(
        leading: const Icon(Icons.delete_outlined),
        title: const Text('Delete'),
        onTap: deleteNote,
      ));
    } else {
      actionList.add(ListTile(
        leading: const Icon(Icons.restore),
        title: const Text('Restore'),
        onTap: restoreNoteAndGoHomeScreen,
      ));
      actionList.add(ListTile(
        leading: const Icon(Icons.delete_outlined),
        title: const Text('Delete completely'),
        onTap: showNoteDeletionConfirmDialog,
      ));
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: actionList,
      ),
    );
  }

  Row buildBottomNavigationBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          disabledColor: Colors.white30,
          icon: const Icon(Icons.add_box_outlined),
          onPressed: !widget.isEditable ? null : () {},
        ),
        IconButton(
          disabledColor: Colors.white30,
          onPressed: !widget.isEditable ? null : () {},
          icon: const Icon(Icons.color_lens_outlined),
        ),
        Expanded(
          child: Text(
            DateFormatter.difference(to: _note.lastEditDate!),
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
          ),
        ),
        const SizedBox(width: 48),
        IconButton(
          onPressed: showActionList,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
