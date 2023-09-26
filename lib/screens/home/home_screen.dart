library home_screen;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/note_provider.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/note_item.dart';
import '../../widgets/user_menu.dart';
import '../new_note/new_note_screen.dart';
import '../search_note/search_note_screen.dart';

part 'home_view_model.dart';

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
        onTap: () => focusClear(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const DrawerMenu(),
          bottomNavigationBar: const _BottomBar(),
          floatingActionButton: _getFloatingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_getHeader(), _getContent()],
          ),
        ),
      ),
    );
  }

  Widget _getHeader() {
    return GestureDetector(
      onTap: navToSearchScreen,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        child: AppBar(
          primary: true,
          scrolledUnderElevation: 0,
          toolbarHeight: 50,
          shape: const StadiumBorder(),
          titleSpacing: 0,
          title: Text(
            'Notlarınızda arayın',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          actions: [
            switchViewButton(),
            const SizedBox(width: 10),
            avatar(),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  IconButton switchViewButton() {
    return IconButton(
      onPressed: toggleGridCrossAxisCount,
      icon: const Icon(Icons.view_agenda_outlined),
    );
  }

  Widget avatar() {
    return GestureDetector(
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

  Widget _getContent() {
    return Expanded(
      child: GridView.count(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        crossAxisCount: _gridCrossAxisCount,
        children: List.generate(
          context.watch<NoteProvider>().notes.length,
          (index) => NoteItem(note: context.watch<NoteProvider>().notes[index]),
        ),
      ),
    );
  }

  Widget _getFloatingButton() {
    return FloatingActionButton(
      onPressed: navToNewNoteScreen,
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
