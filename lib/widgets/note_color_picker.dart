import 'package:flutter/material.dart';

import '../constants/note_colors.dart';

class NoteColorPicker extends StatefulWidget {
  NoteColorPicker({
    super.key,
    this.selected,
    required this.changed,
  }) {
    _colors = [
      NoteColors.none,
      NoteColors.shiraz,
      NoteColors.sisKebab,
      NoteColors.forwardFuchsia,
      NoteColors.royalPurple,
      NoteColors.botanicalNight,
      NoteColors.mallard,
      NoteColors.pacificNavy,
      NoteColors.youngNight,
    ];
  }

  late final List<Color> _colors;
  final ValueChanged<Color?> changed;
  Color? selected;

  @override
  State<NoteColorPicker> createState() => _NoteColorPickerState();
}

class _NoteColorPickerState extends State<NoteColorPicker> {
  late Color selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? widget._colors.first;
  }

  void onTapColorItem(Color color) {
    setState(() {
      selected = color;
    });
    if (selected == widget._colors.first) {
      widget.changed.call(null);
    } else {
      widget.changed.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      color: selected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildColorTitle(context),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: buildGridView(),
          ),
        ],
      ),
    );
  }

  Padding buildColorTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 6),
      child: Text(
        'Color',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  GridView buildGridView() {
    return GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      mainAxisSpacing: 15,
      children: List.generate(
        widget._colors.length,
        (index) => buildColorItem(index),
      ),
    );
  }

  InkWell buildColorItem(int index) {
    final Color color = widget._colors[index];

    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => onTapColorItem(color),
      child: _ColorItem(
        selected: selected.value == color.value,
        color: color,
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  _ColorItem({
    required this.color,
    this.selected = false,
  });

  bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Container buildContainer() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: selected ? buildSelectedBorder() : buildDefaultBorder(),
      ),
      child: color == Colors.transparent
          ? buildTransparentColorCircleAvatar()
          : buildCircleAvatar(),
    );
  }

  CircleAvatar buildCircleAvatar() {
    return CircleAvatar(
      backgroundColor: selected ? color : color.withOpacity(.5),
      child: selected ? buildCheckIcon() : null,
    );
  }

  CircleAvatar buildTransparentColorCircleAvatar() {
    return CircleAvatar(
      backgroundColor: selected ? Colors.black : Colors.black54,
      child: selected
          ? buildCheckIcon()
          : const Icon(
              Icons.format_color_reset_outlined,
              size: 40,
              color: Colors.white,
            ),
    );
  }

  Border buildDefaultBorder() => Border.all(width: 1, color: Colors.white);
  Border buildSelectedBorder() => Border.all(width: 2, color: Colors.lightBlue);

  Icon buildCheckIcon() =>
      const Icon(Icons.check, size: 40, color: Colors.lightBlue);
}
