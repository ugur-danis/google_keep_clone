import 'package:flutter/material.dart';

import '../constants/note_colors.dart';

class NoteColorPicker extends StatefulWidget {
  NoteColorPicker({
    super.key,
    this.selected,
    this.title = 'Color',
    this.horizontal = true,
    this.dialog = false,
    required this.changed,
  });

  final List<Color> _colors = [
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
  final ValueChanged<Color?> changed;
  final String title;
  final bool horizontal;
  final bool dialog;
  final Color? selected;

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
      height: widget.horizontal ? 160 : MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      color: widget.dialog ? null : selected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildColorTitle(context),
          buildGridView(),
        ],
      ),
    );
  }

  Padding buildColorTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 6),
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Expanded buildGridView() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: widget.horizontal ? 1 : 4,
        scrollDirection: widget.horizontal ? Axis.horizontal : Axis.vertical,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: List.generate(
          widget._colors.length,
          (index) => buildColorItem(index),
        ),
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
  const _ColorItem({
    required this.color,
    this.selected = false,
  });

  final bool selected;
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
