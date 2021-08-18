import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pix/data/model/photo_response.dart';

class ImageDetailsPage extends StatefulWidget {
  final Photo photo;
  final String heroTag;

  const ImageDetailsPage({Key? key, required this.photo,required this.heroTag}) : super(key: key);

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  bool _loadHd = false;
  late PhotoViewScaleStateController _photoViewController;
  bool _hideAll = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photoViewController = PhotoViewScaleStateController();
    _photoViewController.outputScaleStateStream.listen((event) {
      setState(() {
        _hideAll = event == PhotoViewScaleState.zoomedIn ||
            event == PhotoViewScaleState.covering || event == PhotoViewScaleState.originalSize ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var photo = widget.photo;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          setState(() {
            _loadHd = true;
          });
        },
        child: Icon(
          Icons.hd,
          size: 40,
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CenteredView(
          child: Stack(
            children: [
              Hero(
                tag: widget.heroTag,
                transitionOnUserGestures: true,
                child: PhotoView(
                  filterQuality: FilterQuality.high,
                  scaleStateController: _photoViewController,
                  loadingBuilder: (context, _) {
                    return CircularProgressIndicator();
                  },
                  imageProvider: CachedNetworkImageProvider(
                      _loadHd ? photo.largeImageURL : photo.webformatURL),
                ),
              ),
              /*AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _hideAll ? 0.0 : 1.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    color: Colors.black45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: OctoImage(
                              image:
                                  CachedNetworkImageProvider(photo.userImageURL),
                              width: 50,
                              height: 50),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              photo.user,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          children: photo.tags
                              .split(",")
                              .map((e) => Chip(label: Text(e),backgroundColor: Colors.white,))
                              .toList(),
                          spacing: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

class CenteredView extends StatelessWidget {
  final Widget child;

  const CenteredView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200),
        child: child,
      ),
    );
  }
}
