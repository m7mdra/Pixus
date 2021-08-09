import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final Video video;

  const VideoWidget({Key? key, required this.video}) : super(key: key);

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
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
             OctoImage(
                width: width,
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    "https://i.vimeocdn.com/video/${widget.video.pictureId}_640.jpg"),
                placeholderBuilder: (context) {
                  return CachedNetworkImage(
                      imageUrl:
                          "https://i.vimeocdn.com/video/${widget.video.pictureId}_150.jpg",
                      fit: BoxFit.cover,
                      width: width);
                },
              ),
          Icon(FontAwesomeIcons.solidPlayCircle,
              size: 50, color: Colors.white)
      ],
    );
  }
}
