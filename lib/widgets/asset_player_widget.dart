import "package:flutter/material.dart";
import 'package:on_the_way_mobile/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class AssetPlayerWidget extends StatefulWidget {
  final String link;
  const AssetPlayerWidget({Key key, this.link}) : super(key: key);

  @override
  _AssetPlayerWidgetState createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.link)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Column(
      children: [
        VideoPlayerWidget(controller: controller),
        const SizedBox(
          height: 32,
        ),
        if (controller != null && controller.value.isInitialized)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(
                isMuted ? Icons.volume_mute : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: () => controller.setVolume(isMuted ? 1 : 0),
            ),
          )
      ],
    );
  }
}
