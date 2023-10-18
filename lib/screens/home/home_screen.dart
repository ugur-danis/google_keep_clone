import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/Note.dart';
import '../../services/archive/interfaces/IFirebaseArchiveManager.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/illustrated_message.dart';
import '../../widgets/note_item.dart';
import '../../widgets/user_menu.dart';
import '../edit_note/edit_note_screen.dart';
import '../search_note/search_note_screen.dart';

part 'home_screen_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with _HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: focusClear,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          drawer: const DrawerMenu(screen: DrawerMenuScreens.notes),
          bottomNavigationBar: const _BottomBar(),
          floatingActionButton: buildFloatingButton(),
          appBar: _selectedNotes.isEmpty
              ? buildDefaultAppBar()
              : buildItemSelectedAppBar(),
          body: buildContent(),
        ),
      ),
    );
  }

  PreferredSize buildDefaultAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56 + 10), // with top padding
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: GestureDetector(
          onTap: navToSearchScreen,
          child: AppBar(
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            shape: const StadiumBorder(),
            title: Text(
              'Search in your notes',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            actions: [
              buildSwitchViewButton(),
              const SizedBox(width: 10),
              buildAvatar(),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildItemSelectedAppBar() {
    final List<PopupMenuEntry> popupMenuItems = [
      PopupMenuItem(
        onTap: archiveNotes,
        child: const Text('Archive'),
      ),
      PopupMenuItem(
        onTap: deleteNote,
        child: const Text('Delete'),
      ),
    ];

    if (_selectedNotes.length == 1) {
      popupMenuItems.addAll([
        PopupMenuItem(
          onTap: createNoteCopy,
          child: const Text('Create a copy'),
        ),
        PopupMenuItem(
          onTap: () {},
          child: const Text('Send'),
        )
      ]);
    }

    popupMenuItems.add(PopupMenuItem(
      onTap: () {},
      child: const Text('Copy to Google Docs'),
    ));

    return AppBar(
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      title: Text(
        _selectedNotes.length.toString(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: IconButton(
        onPressed: clearSelectedNotes,
        icon: const Icon(Icons.close),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notification_add_sharp),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.color_lens_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.label_outline),
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) => popupMenuItems,
        ),
      ],
    );
  }

  IconButton buildSwitchViewButton() {
    return IconButton(
      onPressed: toggleGridCrossAxisCount,
      icon: const Icon(Icons.view_agenda_outlined),
    );
  }

  Widget buildAvatar() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const UserMenu();
          },
        );
      },
      child: CircleAvatar(
        radius: 16,
        backgroundImage: context.watch<AuthProvider>().user?.photoURL != null
            ? Image.network(context.watch<AuthProvider>().user!.photoURL!).image
            : null,
      ),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                if (snapshot.data.length < 1) {
                  return buildNoNotesMessage(context);
                }
                return buildGridView(snapshot);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Expanded buildGridView(AsyncSnapshot<dynamic> snapshot) {
    return Expanded(
      child: GridView.count(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        crossAxisCount: _gridCrossAxisCount,
        children: List.generate(
          snapshot.data.length,
          (index) => buildNoteItem(snapshot, index),
        ),
      ),
    );
  }

  NoteItem buildNoteItem(AsyncSnapshot<dynamic> snapshot, int index) {
    final Note note = snapshot.data[index];

    return NoteItem(
      note: note,
      selected: _selectedNotes.contains(note),
      onSelected: (bool isSelected) {
        onChangeSelectedNotes(note, isSelected);
      },
    );
  }

  IllustratedMessage buildNoNotesMessage(BuildContext context) {
    return const IllustratedMessage(
      icon: Icons.lightbulb_outline,
      text: 'Notes you add appear here',
    );
  }

  Widget buildFloatingButton() {
    return FloatingActionButton(
      onPressed: navToEditNoteScreen,
      shape: const CircleBorder(),
      child: SvgPicture.asset('assets/images/google-plus-icon.svg', width: 30),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      shape: const CircularNotchedRectangle(),
      padding: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            tooltip: 'New list',
            icon: const Icon(Icons.check_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'New draw note',
            icon: const Icon(Icons.brush),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'New voice note',
            icon: const Icon(Icons.mic_none),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'New image note',
            icon: const Icon(Icons.image_outlined),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
