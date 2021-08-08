import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';
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
  late PhotosCubit _cubit;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _cubit = PhotosCubit(ServiceLocator.provide());
    _cubit.loadData(_page);
    _pagingController = PagingController<int, Photo>(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadData(pageKey);
    });
    _cubit.stream.listen((state) {
      if (state is PhotosSuccess) {
        _page += 1;
        _pagingController.appendPage(state.list, _page);
      }
      if(state is PhotosEmpty){
        _pagingController.appendLastPage([]);
      }
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
