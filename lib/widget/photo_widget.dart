import 'dart:math';

import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/data/model/photo_response.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
            return Shimmer(
              interval: Duration(milliseconds: 200),
                child: Container(
              width: photo.previewWidth.toDouble()/2,
              height: photo.previewHeight.toDouble()/2,
            ));
          },
        ),
      ], mainAxisSize: MainAxisSize.min),
    );
  }
}
