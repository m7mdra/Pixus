import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pix/data/model/video_response.dart';
import 'package:pix/page/image_details/image_details_page.dart';
import 'package:pix/widget/media_controls.dart';
import 'package:pix/widget/video_player.dart';
class VideoDetailsPage extends StatefulWidget {
  final Video video;

  const VideoDetailsPage({Key? key, required this.video}) : super(key: key);

  @override
  _VideoDetailsPageState createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  late VideoController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoController.network(widget.video.urls?.small?.url ?? "");

    _videoPlayerController.addListener(() {});

    _videoPlayerController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var value = _videoPlayerController.value;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: CenteredView(
        child: value.isInitialized
            ? AspectRatio(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    VideoPlayer(_videoPlayerController, (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PopupMenuButton<Media>(
                          onSelected: (item) {
                            _videoPlayerController.pause();
                            _videoPlayerController =
                                VideoController.network(item.url);
                            _videoPlayerController.initialize()
                              ..then((value) {
                                _videoPlayerController.play();
                                setState(() {});
                              });
                          },
                          itemBuilder: (BuildContext context) {
                            var video = widget.video;
                            return [
                              if (video.urls?.tiny != null) video.urls?.tiny,
                              video.urls?.small,
                              video.urls?.medium,
                              video.urls?.large,
                            ]
                                .where((element) => element != null)
                                .map((e) => e!)
                                .map((e) => PopupMenuItem(
                                      child: Text("${e.width}x${e.height}"),
                                      value: e,
                                    ))
                                .toList();
                          },
                          child: Icon(Icons.hd, size: 25),
                        ),
                      );
                    }),
                  ],
                ),
                aspectRatio: value.aspectRatio)
            : VideoPlaceHolder(video: widget.video),
      ),
    );
  }
}

class VideoPlaceHolder extends StatelessWidget {
  final Video video;

  const VideoPlaceHolder({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: 'video:#${video.id}',
      child: OctoImage(
        fadeInCurve: Curves.linear,
        fadeOutCurve: Curves.linear,
        fadeInDuration: Duration(milliseconds: 1),
        fadeOutDuration: Duration(milliseconds: 1),
        imageBuilder: (BuildContext context, Widget child) {
          return Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.passthrough,
            children: [child, Container(child: CircularProgressIndicator())],
          );
        },
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(
            "https://i.vimeocdn.com/video/${video.pictureId}_640.jpg"),
        placeholderBuilder: (context) {
          return CachedNetworkImage(
              imageUrl: "https://i.vimeocdn.com/video/${video.pictureId}_150.jpg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width);
        },
      ),
    );
  }
}
