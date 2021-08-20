import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/video_details/video_details_page.dart';
import 'package:pix/widget/pixus_app_bar.dart';
import 'package:pix/widget/video_widget.dart';
import 'package:pix/widget/videos_search_filter_widget.dart';

import 'bloc/videos_cubit.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage>
    with AutomaticKeepAliveClientMixin {
  late PagingController<int, Video> _pagingController;
  late VideosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = VideosCubit(ServiceLocator.provide());
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
    return CustomScrollView(
      slivers: [
        PixusAppBar(),
        BlocProvider.value(
          value: _cubit,
          child: SliverPersistentHeader(
              delegate: SearchFilterHeaderDelegate(), floating: true),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: PagedSliverGrid(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Video>(
                itemBuilder: (context, item, index) {
              return VideoWidget(
                video: item,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoDetailsPage(video: item)));
                },
              );
            }),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 2))]),
      child: Center(child: VideoSearchFilter()),
    );
  }

  @override
  double get maxExtent => 75;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
