import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/data/model/photo_response.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;
  final Random random = new Random();
   PhotoWidget({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(children: [
        OctoImage(
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          image: NetworkImage(photo.webformatURL),
          placeholderBuilder: (context) {
            return Center(child: CircularProgressIndicator());
          },
        ),

      ], mainAxisSize: MainAxisSize.min),
    );
  }
}
