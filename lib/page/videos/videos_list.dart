import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/video_details/video_details_page.dart';
import 'package:pix/widget/video_widget.dart';

import 'bloc/videos_cubit.dart';

class VideoLists extends StatefulWidget {
  final Category category;

  const VideoLists({Key? key, required this.category}) : super(key: key);

  @override
  _VideoListsState createState() => _VideoListsState();
}

class _VideoListsState extends State<VideoLists>
    with AutomaticKeepAliveClientMixin {
  late PagingController<int, Video> _pagingController;
  late VideosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = VideosCubit(ServiceLocator.provide());
    _cubit.category = widget.category;
    _pagingController = PagingController<int, Video>(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadData();
    });
    _cubit.stream.listen((state) {
      if (state is VideosSuccess) {
        _pagingController.appendPage(state.list, _cubit.page);
      }
      if (state is VideosRefresh) {
        _pagingController.refresh();
      }
      if (state is VideosEmpty) {
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
          PagedChildBuilderDelegate<Video>(itemBuilder: (context, item, index) {
        return VideoWidget(
            heroTag: _heroTag(index),
            video: item,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoDetailsPage(
                            video: item,
                            heroTag: _heroTag(index),
                          )));
            });
      }),
      scrollDirection: Axis.horizontal,
    );
  }

  _heroTag(index) => "${widget.category.name}video:$index";

  @override
  bool get wantKeepAlive => true;
}
