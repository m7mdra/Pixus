import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:math' as math;
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Paged [SliverGrid] with progress and error indicators displayed as the last
/// item.
///
/// Similar to [PagedGridView] but needs to be wrapped by a
/// [CustomScrollView] when added to the screen.
/// Useful for combining multiple scrollable pieces in your UI or if you need
/// to add some widgets preceding or following your paged grid.
///
class SliverPagingStaggeredGridView<PageKeyType, ItemType> extends StatelessWidget {
  const SliverPagingStaggeredGridView({
    required this.pagingController,
    required this.builderDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.showNewPageProgressIndicatorAsGridChild = true,
    this.showNewPageErrorIndicatorAsGridChild = true,
    this.showNoMoreItemsIndicatorAsGridChild = true,
    this.shrinkWrapFirstPageIndicators = false,
    Key? key,
  }) : super(key: key);

  /// Corresponds to [PagedSliverBuilder.pagingController].
  final PagingController<PageKeyType, ItemType> pagingController;

  /// Corresponds to [PagedSliverBuilder.builderDelegate].
  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  /// Corresponds to [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Corresponds to [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Corresponds to [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Whether the new page progress indicator should display as a grid child
  /// or put below the grid.
  ///
  /// Defaults to true.
  final bool showNewPageProgressIndicatorAsGridChild;

  /// Whether the new page error indicator should display as a grid child
  /// or put below the grid.
  ///
  /// Defaults to true.
  final bool showNewPageErrorIndicatorAsGridChild;

  /// Whether the no more items indicator should display as a grid child
  /// or put below the grid.
  ///
  /// Defaults to true.
  final bool showNoMoreItemsIndicatorAsGridChild;

  /// Corresponds to [PagedSliverBuilder.shrinkWrapFirstPageIndicators].
  final bool shrinkWrapFirstPageIndicators;

  @override
  Widget build(BuildContext context) =>
      PagedSliverBuilder<PageKeyType, ItemType>(
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        completedListingBuilder:
            (context, itemBuilder, itemCount, noMoreItemsIndicatorBuilder) {
          return _AppendedSliverGrid(
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            appendixBuilder: noMoreItemsIndicatorBuilder,
            showAppendixAsGridChild: showNoMoreItemsIndicatorAsGridChild,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addSemanticIndexes: addSemanticIndexes,
            addRepaintBoundaries: addRepaintBoundaries,
          );
        },
        loadingListingBuilder:
            (context, itemBuilder, itemCount, progressIndicatorBuilder) {
          return _AppendedSliverGrid(
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            appendixBuilder: progressIndicatorBuilder,
            showAppendixAsGridChild: showNewPageProgressIndicatorAsGridChild,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addSemanticIndexes: addSemanticIndexes,
            addRepaintBoundaries: addRepaintBoundaries,
          );
        },
        errorListingBuilder:
            (context, itemBuilder, itemCount, errorIndicatorBuilder) {
          return _AppendedSliverGrid(
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            appendixBuilder: errorIndicatorBuilder,
            showAppendixAsGridChild: showNewPageErrorIndicatorAsGridChild,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addSemanticIndexes: addSemanticIndexes,
            addRepaintBoundaries: addRepaintBoundaries,
          );
        },
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      );
}

class _AppendedSliverGrid extends StatelessWidget {
  const _AppendedSliverGrid({
    required this.itemBuilder,
    required this.itemCount,
    this.showAppendixAsGridChild = true,
    this.appendixBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    Key? key,
  }) : super(key: key);
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool showAppendixAsGridChild;
  final WidgetBuilder? appendixBuilder;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
//TODO: pass #staggeredTileBuilder by constructor
  @override
  Widget build(BuildContext context) {
    if (showAppendixAsGridChild == true || appendixBuilder == null) {
      return SliverStaggeredGrid(
          delegate: _buildSliverDelegate(appendixBuilder: appendixBuilder),
          gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 12,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            staggeredTileCount: itemCount,
            staggeredTileBuilder: (index) => StaggeredTile.fit(6),
          ));
    } else {
      return MultiSliver(children: [
        SliverStaggeredGrid(
            delegate: _buildSliverDelegate(appendixBuilder: appendixBuilder),
            gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 12,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              staggeredTileCount: itemCount,
              staggeredTileBuilder: (index) => StaggeredTile.fit(6),
            )),
        SliverToBoxAdapter(
          child: appendixBuilder!(context),
        ),
      ]);
    }
  }

  SliverChildBuilderDelegate _buildSliverDelegate({
    WidgetBuilder? appendixBuilder,
  }) =>
      AppendedSliverChildBuilderDelegate(
        builder: itemBuilder,
        childCount: itemCount,
        appendixBuilder: appendixBuilder,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      );
}

/// A [SliverChildBuilderDelegate] with an extra item (appendixBuilder) added
/// to the end.
///
/// To include list separators, use
/// [AppendedSliverChildBuilderDelegate.separated].
class AppendedSliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  AppendedSliverChildBuilderDelegate({
    required IndexedWidgetBuilder builder,
    required int childCount,
    WidgetBuilder? appendixBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) : super(
    appendixBuilder == null
        ? builder
        : (context, index) {
      if (index == childCount) {
        return appendixBuilder(context);
      }
      return builder(context, index);
    },
    childCount: appendixBuilder == null ? childCount : childCount + 1,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: semanticIndexCallback ?? (_, index) => index,
  );

  AppendedSliverChildBuilderDelegate.separated({
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder separatorBuilder,
    WidgetBuilder? appendixBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
    builder: (context, index) {
      final itemIndex = index ~/ 2;
      if (index.isEven) {
        return builder(context, itemIndex);
      }

      return separatorBuilder(context, itemIndex);
    },
    childCount: math.max(
      0,
      childCount * 2 - (appendixBuilder != null ? 0 : 1),
    ),
    appendixBuilder: appendixBuilder,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
  );
}
