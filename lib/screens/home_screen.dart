import 'package:flutter/material.dart';
import 'package:google_keep_clone/constants/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Header(),
            _Content(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        child: AppBar(
          primary: true,
          scrolledUnderElevation: 0,
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: CustomColors.bottomAppBarBg,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          titleSpacing: 0,
          title: const Text(
            'Notlarınızda arayın',
            style: TextStyle(color: CustomColors.actionsColor, fontSize: 14),
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

  Widget avatar() {
    return GestureDetector(
      onTap: () {},
      child: const CircleAvatar(
        radius: 16,
        backgroundImage: AssetImage('assets/images/profile-img.png'),
      ),
    );
  }

  IconButton switchViewButton() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.view_agenda_outlined,
          color: CustomColors.actionsColor,
        ));
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          crossAxisCount: 2,
          children: List.generate(4, (index) => const Card())),
    );
  }
}