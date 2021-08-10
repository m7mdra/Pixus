import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/data/model/video_type.dart';
import 'package:pix/page/videos/bloc/videos_cubit.dart';
import 'package:pix/widget/chip_drop_down.dart';

class VideoSearchFilter extends StatefulWidget {
  const VideoSearchFilter({Key? key}) : super(key: key);

  @override
  _VideoSearchFilterState createState() => _VideoSearchFilterState();
}

class _VideoSearchFilterState extends State<VideoSearchFilter> {
  var _selectedOrder = Order.popular;
  Category _selectedCategory = Category.all;
  VideoType _selectedVideoType = VideoType.all;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChipDropDown<Order>(
                onSelect: (order) {
                  setState(() {
                    this._selectedOrder = order;
                  });
                  _filter();
                },
                values: Order.values
                    .map((e) =>
                    PopupMenuItem<Order>(child: Text(e.name), value: e))
                    .toList(),
                title: 'Order',
                chipText: _selectedOrder.name),
            _sizedBox(),
            ChipDropDown<Category>(
                onSelect: (category) {
                  setState(() {
                    this._selectedCategory = category;
                  });
                  _filter();
                },
                values: Category.values
                    .map((e) => PopupMenuItem(child: Text(e.name), value: e))
                    .toList(),
                chipText: _selectedCategory.name,
                title: "Category"),
            _sizedBox(),

            ChipDropDown<VideoType>(
                onSelect: (value) {
                  setState(() {
                    this._selectedVideoType = value;
                  });
                  _filter();
                },
                values: VideoType.values
                    .map((e) => PopupMenuItem(child: Text(e.name), value: e))
                    .toList(),
                chipText: _selectedVideoType.name,
                title: "Type"),


          ]),
    );
  }

  SizedBox _sizedBox() => SizedBox(width: 4);

  void _filter() {
    BlocProvider.of<VideosCubit>(context).refresh(order: _selectedOrder,
        category: _selectedCategory,
        videoType: _selectedVideoType);
  }

  void clearFilters() {
    BlocProvider.of<VideosCubit>(context).clearFilter();
    setState(() {
      _selectedOrder = Order.popular;
      _selectedVideoType = VideoType.all;
      _selectedCategory = Category.all;
    });
  }
}
