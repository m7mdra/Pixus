import 'package:flutter/material.dart';
import 'package:pix/breakpoints.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/page/category/photo_category_page.dart';
import 'package:pix/page/photos/photos_list.dart';
import 'package:pix/widget/centered.dart';
import 'package:pix/widget/photos_search_filter_widget.dart';
import 'package:pix/widget/search_widget.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage>
    with AutomaticKeepAliveClientMixin {
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhotoCategoryPage(
                                            category: categories[index])));
                              },
                              child: Text('See more'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        child: PhotosList(category: categories[index]),
                        height: imageWidth(MediaQuery.of(context).size.width).value,
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
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        PhotosSearchFilter(),
      ]),
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
