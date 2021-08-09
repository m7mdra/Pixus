import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/breakpoints.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';
import 'package:pix/page/photos/bloc/photos_state.dart';
import 'package:pix/widget/photo_widget.dart';
import 'package:pix/widget/search_filter_widget.dart';
import 'package:pix/widget/search_widget.dart';
import 'package:pix/widget/sliver_paged_staggered_grid_view.dart';

import 'bloc/photos_cubit.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage>
    with AutomaticKeepAliveClientMixin {
  late PagingController<int, Photo> _pagingController;
  late PhotosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PhotosCubit(ServiceLocator.provide());
    _cubit.loadData();
    _pagingController = PagingController<int, Photo>(firstPageKey: 1);

    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadData();
    });
    _cubit.stream.listen((state) {
      if (state is PhotosSuccess) {
        _pagingController.appendPage(state.list, _cubit.page);
      }
      if(state is PhotosError){
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= kMobileBreakpoint) {
          return Text('mega');
        } else {
          return CustomScrollView(
            slivers: [
              BlocProvider.value(
                  value: _cubit,
                  child: SliverPersistentHeader(
                    delegate: SearchFilterHeaderDelegate(),
                    pinned: false,
                    floating: true,
                  )),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverPagingStaggeredGridView(

                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Photo>(
                      itemBuilder: (context, item, index) {
                    return PhotoWidget(photo: item);
                  }),
                  axisCellCount: calculateColumnRatio(constraints),
                ),
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

class SearchFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 2))]),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            'Pixus',
            style: GoogleFonts.lobster(color: Colors.white, fontSize: 50),
          ),
          VerticalDivider(),
          SearchFilterWidget(),
          VerticalDivider(),
          Flexible(child: SearchWidget(),flex: 2),
          Spacer(),
        ],
      ),
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

