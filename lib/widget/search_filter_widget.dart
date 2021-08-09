import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix/data/model/category.dart';
import 'package:pix/data/model/color.dart';
import 'package:pix/data/model/image_type.dart';
import 'package:pix/data/model/order.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';
import 'package:pix/widget/chip_drop_down.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({Key? key}) : super(key: key);

  @override
  _SearchFilterWidgetState createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  var _selectedOrder = Order.popular;
  var _selectedImageType = ImageType.all;
  C? _selectedColor;
  Category? _selectedCategory;

  void _filter() {
    BlocProvider.of<PhotosCubit>(context)
        .refresh(imageType: _selectedImageType,
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
                chipText: _selectedColor?.name ?? "No value",
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
                chipText: _selectedCategory?.name ?? "No value",
                title: "Category"),

          ]),
    );
  }

  SizedBox _sizedBox() => SizedBox(width: 4);
}
