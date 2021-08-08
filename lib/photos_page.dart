
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/raw_data.dart';
import 'package:pix/widget/photo_widget.dart';
import 'package:pix/widget/sliver_paged_staggered_grid_view.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage>
    with AutomaticKeepAliveClientMixin {
  late PagingController<int, Photo> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, Photo>(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        _pagingController.appendLastPage(photos.list);
      });
    });
    Future.delayed(Duration(seconds: 1)).then((value) {
      _pagingController.appendPage(photos.list, 2);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Container()),

        SliverPagingStaggeredGridView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Photo>(
              itemBuilder: (context, item, index) {
            return PhotoWidget(photo: item);
          }, noMoreItemsIndicatorBuilder: (context) {
            return Text('Finished');
          }),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

