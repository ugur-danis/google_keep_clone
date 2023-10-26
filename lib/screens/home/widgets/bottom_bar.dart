part of '../home_screen.dart';

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(0),
      shape: const CircularNotchedRectangle(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.check_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.brush),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.mic_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.image_outlined),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
