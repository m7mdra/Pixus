import "dart:async";

import "package:flutter/material.dart";
import "package:video_player/video_player.dart" as plugin;

import 'media_controls.dart';


/// A video player with controls overlayed.
///
/// This widget is meant to replace the VideoPlayer from `package:video_player`.
/// This widget puts a [VideoControls] widget on top, and manages full-screen
/// transitions. However, the logic still depends on VideoPlayerController,
/// but with an added property. Use [VideoController] from this package instead.
class VideoPlayer extends StatefulWidget {
  /// The controller backing this player.
  final VideoController controller;
  final WidgetBuilder qulityBuilder;
  /// Creates a video player with controls overlayed.
  const VideoPlayer(this.controller,this.qulityBuilder);

  @override
  VideoPlayerState createState() => VideoPlayerState();
}

/// The state for a [VideoPlayer].
///
/// Manages full-screen transitions and overlays the controls atop the video.
class VideoPlayerState extends State<VideoPlayer> {
  /// The [VideoController] for this video.
  VideoController get controller => widget.controller;

  /// Whether this video is ready to be played.
  bool get isReady => controller.value.isInitialized;

  bool isHovering = false;

  Timer? disableControls;

  @override
  void initState() {
    super.initState();
    init();
  }

  /// Initializes the video, if it isn't already, and rebuilds.
  Future<void> init() async {
    if (isReady) return;
    await controller.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Listener(
          onPointerDown: (_) async {
            setState(() => isHovering = true);
            await Future.delayed(const Duration(seconds: 1));
            setState(() => isHovering = false);
          },
          onPointerHover: (_) {
            setState(() => isHovering = true);
            disableControls?.cancel();
            disableControls = Timer(
                const Duration(seconds: 2),
                    () => setState(() => isHovering = false)
            );
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
              children: [
                // Video background
                if (isReady) plugin.VideoPlayer(controller)
                else Container(color: Colors.grey.shade200.withOpacity(0.1)),

                // Controls foreground
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: controller.value.isPlaying && !isHovering ? Container() : Align(
                        alignment: Alignment.bottomCenter,
                        child: !isReady ? const LinearProgressIndicator() : SizedBox(
                            height: 100,
                            child: VideoControls(
                              controller,
                            widget.qulityBuilder
                            )
                        )
                    )
                )
              ]
          )
      )
  );

}
