import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/breakpoints.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/widget/sliver_paged_staggered_grid_view.dart';
import 'package:pix/widget/video_widget.dart';

import 'bloc/videos_cubit.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage>  with AutomaticKeepAliveClientMixin {
  late PagingController<int, Video> _pagingController;
  late VideosCubit _cubit;
  int _page = 1;
  @override
  void initState() {
    super.initState();
    _cubit = VideosCubit(ServiceLocator.provide());
    _cubit.loadData(_page);
    _pagingController = PagingController<int, Video>(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadData(pageKey);
    });
    _cubit.stream.listen((state) {
      if (state is VideosSuccess) {
        _page += 1;
        _pagingController.appendPage(state.list, _page);
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
    return  LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= kMobileBreakpoint) {
          return Text('mega');
        } else {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(),
              SliverPagingStaggeredGridView(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Video>(
                    itemBuilder: (context, item, index) {
                      return VideoWidget(video: item);
                    }, noMoreItemsIndicatorBuilder: (context) {
                  return Text('Finished');
                }),
                axisCellCount: calculateColumnRatio(constraints),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
