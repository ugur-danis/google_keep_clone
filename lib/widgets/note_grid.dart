import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

@immutable
class NoteGrid extends StatelessWidget {
  const NoteGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  final List<dynamic> items;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  /// Optional padding
  /// Default value [(horizontal: 10, vertical: 10)]
  final EdgeInsets? padding;

  EdgeInsets getPadding() =>
      padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: getPadding(),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: physics,
      shrinkWrap: shrinkWrap,
      crossAxisCount: crossAxisCount,
      itemCount: items.length,
      itemBuilder: itemBuilder,
    );
  }
}
