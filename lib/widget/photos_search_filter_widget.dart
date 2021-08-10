import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/color.dart';
import 'package:pix/data/model/image_type.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';
import 'package:pix/widget/chip_drop_down.dart';

class PhotosSearchFilter extends StatefulWidget {
  const PhotosSearchFilter({Key? key}) : super(key: key);

  @override
  _PhotosSearchFilterState createState() => _PhotosSearchFilterState();
}

class _PhotosSearchFilterState extends State<PhotosSearchFilter> {
  var _selectedOrder = Order.popular;
  var _selectedImageType = ImageType.all;
  C _selectedColor = C.all;
  Category _selectedCategory = Category.all;

  void _filter() {
    BlocProvider.of<PhotosCubit>(context).refresh(
        imageType: _selectedImageType,
        order: _selectedOrder,
        color: _selectedColor,
        category: _selectedCategory);
  }



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
            ChipDropDown<ImageType>(
                onSelect: (type) {
                  setState(() {
                    this._selectedImageType = type;
                  });
                  _filter();
                },
                values: ImageType.values
                    .map((e) =>
                        PopupMenuItem<ImageType>(child: Text(e.name), value: e))
                    .toList(),
                chipText: _selectedImageType.name,
                title: "Type"),
            _sizedBox(),
            ChipDropDown<C>(
                onSelect: (color) {
                  setState(() {
                    this._selectedColor = color;
                  });
                  _filter();
                },
                values: C.values
                    .map((e) => PopupMenuItem<C>(child: Text(e.name), value: e))
                    .toList(),
                chipText: _selectedColor.name,
                title: "Color"),
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

          ]),
    );
  }

  SizedBox _sizedBox() => SizedBox(width: 4);

  void clearFilters() {
    BlocProvider.of<PhotosCubit>(context).clearFilter();
    setState(() {
      _selectedImageType = ImageType.all;
      _selectedCategory = Category.all;
      _selectedColor = C.all;
      _selectedOrder = Order.popular;
    });
  }
}
