import "package:flutter/material.dart";
import 'package:on_the_way_mobile/widgets/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({Key key, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(
              alignment: Alignment.topCenter,
              child: Container(
                  child: buildVideo(),
                  height: MediaQuery.of(context).size.height - 200),
            )
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

  Widget buildVideo() => Stack(children: [
        buildVideoPlayer(),
        Positioned.fill(child: BasicOverlayWidget(controller: controller))
      ]);

  Widget buildVideoPlayer() => AspectRatio(
        child: VideoPlayer(controller),
        aspectRatio: controller.value.aspectRatio,
      );
}
