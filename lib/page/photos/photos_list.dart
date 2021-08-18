import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/page/image_details/image_details_page.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';
import 'package:pix/widget/photo_widget.dart';

import '../../locator.dart';
import 'bloc/photos_state.dart';

class PhotosList extends StatefulWidget {
  final Category category;

  const PhotosList({Key? key, required this.category}) : super(key: key);

  @override
  _PhotosListState createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList>
    with AutomaticKeepAliveClientMixin {
  late PagingController<int, Photo> _pagingController;
  late PhotosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PhotosCubit(ServiceLocator.provide());
    _cubit.category = widget.category;
    _pagingController = PagingController<int, Photo>(firstPageKey: 1);

    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadData();
    });
    _cubit.stream.listen((state) {
      if (state is PhotosSuccess) {
        _pagingController.appendLastPage(state.list);
      }
      if (state is PhotosError) {
        _pagingController.error = "Failed to load data";
      }
      if (state is PhotosRefresh) {
        _pagingController.refresh();
      }
      if (state is PhotosEmpty) {
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
    return PagedListView(
      shrinkWrap: true,
      pagingController: _pagingController,
      builderDelegate:
          PagedChildBuilderDelegate<Photo>(itemBuilder: (context, item, index) {
        return PhotoWidget(
            heroTag: _heroTag(index),
            photo: item,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageDetailsPage(
                            photo: item,
                            heroTag: _heroTag(index),
                          )));
            });
      }),
      scrollDirection: Axis.horizontal,
    );
  }

  _heroTag(index) => "${widget.category.name}:$index";

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
