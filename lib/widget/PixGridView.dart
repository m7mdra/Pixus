import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PixusGridView extends StatelessWidget {
  const PixusGridView(
      {Key? key,
      required this.columnRatio,
      required this.itemBuilder,
      required this.itemCount})
      : super(key: key);
  final int columnRatio;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      primary: false,
      crossAxisCount: 12,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      staggeredTileBuilder: (index) => StaggeredTile.fit(columnRatio),
    );
  }
}
