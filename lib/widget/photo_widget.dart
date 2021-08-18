import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/data/model/photo_response.dart';

class PhotoWidget extends StatefulWidget {
  final Photo photo;
  final VoidCallback? onTap;
  final String heroTag;

  PhotoWidget(
      {Key? key, required this.photo, this.onTap, required this.heroTag})
      : super(key: key);

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  var width = 300.0;
  var height = 300.0;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          width = 400;
          height = 250;
        });
      },
      onExit: (event){
        setState(() {
          width = 300;
          height = 300;
        });
      },
      child: AnimatedContainer(
        width: width,
        height: height,
        padding: const EdgeInsetsDirectional.only(end: 8),
        duration: Duration(milliseconds: 200),
        child: Hero(
          transitionOnUserGestures: true,
          tag: widget.heroTag,
          child: OctoImage(
            fadeInCurve: Curves.linear,
            fadeOutCurve: Curves.linear,
            fadeInDuration: Duration(milliseconds: 1),
            fadeOutDuration: Duration(milliseconds: 1),
            fit: BoxFit.cover,
            width: width,
            height: height,
            image: CachedNetworkImageProvider(widget.photo.webformatURL),
            placeholderBuilder: (context) {
              return CachedNetworkImage(
                  imageUrl: widget.photo.previewURL, fit: BoxFit.cover, width: width);
            },
          ),
        ),
      ),
    );
  }
}
