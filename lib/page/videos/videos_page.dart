import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/breakpoints.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/videos/videos_list.dart';
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
    var categories = Category.values;

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(categories[index].name,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: TextButton(
                              onPressed: () {
                                /*               Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhotoCategoryPage(
                                            category: categories[index])));*/
                              },
                              child: Text('See more'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        child: VideoLists(category: categories[index]),
                        height:
                            imageWidth(MediaQuery.of(context).size.width).value,
                      )
                    ],
                  );
                },
                itemCount: categories.length),
          ),
        ],
      ),
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
