import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/data/model/photo_response.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;
  final VoidCallback? onTap;

  PhotoWidget({Key? key, required this.photo, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Hero(
        transitionOnUserGestures: true,
        tag: "photo#${photo.id}",
        child: OctoImage(
          fadeInCurve: Curves.linear,
          fadeOutCurve: Curves.linear,
          fadeInDuration: Duration(milliseconds: 1),
          fadeOutDuration: Duration(milliseconds: 1),
          fit: BoxFit.cover,
          width: width,
          image: CachedNetworkImageProvider(photo.webformatURL),
          placeholderBuilder: (context) {
            return CachedNetworkImage(
                imageUrl: photo.previewURL, fit: BoxFit.cover, width: width);
          },
        ),
      ),
    );
  }
}
