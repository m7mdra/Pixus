import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/breakpoints.dart';
import 'package:pix/data/model/video_response.dart';

class VideoWidget extends StatefulWidget {
  final Video video;
  final String heroTag;
  final VoidCallback? onTap;

  const VideoWidget(
      {Key? key, required this.video, this.onTap, required this.heroTag})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var diemn = imageWidth(screenWidth);
    var width = diemn.key;
    var height = diemn.value;
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        width: width,
        height: height,
        padding: const EdgeInsetsDirectional.only(end: 8),
        duration: Duration(milliseconds: 500),
        child: Hero(
          transitionOnUserGestures: true,
          tag: widget.heroTag,
          child: OctoImage(
            fadeInCurve: Curves.linear,
            fadeOutCurve: Curves.linear,
            fadeInDuration: Duration(milliseconds: 1),
            fadeOutDuration: Duration(milliseconds: 1),
            width: width,
            height: height,
            imageBuilder: (BuildContext context, Widget child) {
              return Stack(
                fit: StackFit.passthrough,
                children: [
                  child,
                  Icon(FontAwesomeIcons.solidPlayCircle,
                      size: 50, color: Colors.white)
                ],
              );
            },
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
                "https://i.vimeocdn.com/video/${widget.video.pictureId}_640.jpg"),
            placeholderBuilder: (context) {
              return CachedNetworkImage(
                imageUrl:
                    "https://i.vimeocdn.com/video/${widget.video.pictureId}_150.jpg",
                fit: BoxFit.cover,
                width: width,
                height: height,
              );
            },
          ),
        ),
      ),
    );
  }
}
