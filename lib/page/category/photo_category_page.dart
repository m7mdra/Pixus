import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:pix/locator.dart';
import 'package:pix/page/photo_details/photo_details_page.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';
import 'package:pix/page/photos/bloc/photos_state.dart';
import 'package:pix/widget/photo_widget.dart';
import 'package:pix/widget/pixus_app_bar.dart';

class PhotoCategoryPage extends StatefulWidget {
  final Category category;

  const PhotoCategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _PhotoCategoryPageState createState() => _PhotoCategoryPageState();
}

class _PhotoCategoryPageState extends State<PhotoCategoryPage> {
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
        _pagingController.appendPage(state.list, _cubit.page);
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PixusAppBar.sliver(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: PagedSliverGrid(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Photo>(
                  itemBuilder: (context, item, index) {
                return PhotoWidget(
                  photo: item,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotoDetailsPage(
                                  photo: item,
                                  heroTag: _heroTag(index),
                                )));
                  },
                  heroTag: _heroTag(index),
                );
              }),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 8),
            ),
          )
        ],
      ),
    );
  }

  _heroTag(index) => "${widget.category.name}:$index";
}
