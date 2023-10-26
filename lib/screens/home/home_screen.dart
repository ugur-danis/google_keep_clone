import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/Note.dart';
import '../../providers/theme_provider.dart';
import '../../services/archive/interfaces/IFirebaseArchiveManager.dart';
import '../../services/note/interfaces/IFirebaseNoteManager.dart';
import '../../providers/auth_provider.dart';
import '../../utils/theme/system_ui_theme.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/illustrated_message.dart';
import '../../widgets/note_item.dart';
import '../../widgets/user_menu.dart';
import '../edit_note/edit_note_screen.dart';
import '../search_note/search_note_screen.dart';

part 'home_screen_model.dart';
part 'widgets/bottom_bar.dart';
part 'widgets/user_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with RouteAware, _HomeScreenMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPop();
    setSystemUITheme();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    context.read<ThemeProvider>().getAppTheme.setDefaultSystemUIOverlayStyle();
  }

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
          appBar: _selectedNotes.isNotEmpty ? buildItemSelectedAppBar() : null,
          body: buildContent(),
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
          onPressed: updateNotePinned,
          icon: Icon(_selectedNotes.any((n) => n.pinned == false)
              ? Icons.push_pin_outlined
              : Icons.push_pin),
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

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          if (_selectedNotes.isNotEmpty) return [];
          return [buildSliverAppBar(context)];
        },
        body: buildNotesStreamBuilder(),
      ),
    );
  }

  SliverPadding buildSliverAppBar(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20),
      sliver: SliverAppBar(
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
          const _UserAvatar(),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  StreamBuilder<List<Note>> buildNotesStreamBuilder() {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildErrorMessage(snapshot.error);
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return buildNoNotesMessage(context);
          }
          return buildGridViews(snapshot.data!);
        }
        return buildProgressIndicator();
      },
    );
  }

  Widget buildGridViews(List<Note> notes) {
    final List<Note> unpinnedNotes = filterNotesByPinned(notes, false);
    final List<Note> pinnedNotes = filterNotesByPinned(notes, true);

    final List<Widget> children = [];

    if (pinnedNotes.isNotEmpty) {
      children.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Text(
            'Pinned',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ));
      children.add(buildNoteSliverGrid(pinnedNotes));
    }
    if (pinnedNotes.isNotEmpty && unpinnedNotes.isNotEmpty) {
      children.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
          child: Text(
            'Others',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ));
    }
    if (unpinnedNotes.isNotEmpty) {
      children.add(buildNoteSliverGrid(unpinnedNotes));
    }

    return CustomScrollView(slivers: children);
  }

  SliverGrid buildNoteSliverGrid(List<Note> notes) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => buildNoteItem(notes[index]),
        childCount: notes.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridCrossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
    );
  }

  NoteItem buildNoteItem(Note note) {
    return NoteItem(
      note: note,
      selected: _selectedNotes.contains(note),
      onSelected: (bool isSelected) {
        onChangeSelectedNotes(note, isSelected);
      },
    );
  }

  Center buildErrorMessage(Object? error) {
    return Center(child: Text(error.toString()));
  }

  Center buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
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
