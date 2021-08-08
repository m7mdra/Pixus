import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      child: Container(
        child: TextField(
            decoration: InputDecoration(
                hintText: 'Search for images',
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(FontAwesomeIcons.search,
                      color: Colors.grey, size: 20),
                ),
                border: InputBorder.none,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 8))),
        width: MediaQuery.of(context).size.width / 3,
      ),
    );
  }
}
