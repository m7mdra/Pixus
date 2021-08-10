import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pix/page/photos/bloc/photos_cubit.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        child: TextField(
            onChanged: (input) {
              var photosCubit = BlocProvider.of<PhotosCubit>(context);
              if (input.isEmpty) {
                photosCubit.clearFilter();
              } else {
                photosCubit.refresh(query: input);
              }
            },
            decoration: InputDecoration(
                hintText: 'Search for images',
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(FontAwesomeIcons.search,
                      color: Colors.grey, size: 20),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8))),
      ),
    );
  }
}
