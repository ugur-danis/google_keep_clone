part of 'home_screen.dart';

mixin _HomeScreenMixin on State<HomeScreen> {
  int _gridCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().configure().getNotes();
  }

  void focusClear() => FocusScope.of(context).unfocus();

  void navToSearchScreen() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SearchNoteScreen()));

  void navToNewNoteScreen() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => NewNoteScreen()));

  void toggleGridCrossAxisCount() => setState(() {
        _gridCrossAxisCount = _gridCrossAxisCount == 2 ? 1 : 2;
      });
}
