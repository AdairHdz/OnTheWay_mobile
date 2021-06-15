import "package:flutter/material.dart";
import 'package:on_the_way_mobile/widgets/asset_player_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(
          title: Text(args["fileName"]),
        ),
        body: Column(
          children: [
            AssetPlayerWidget(
              link: "http://192.168.100.173:8080/${args['link']}",
            ),
          ],
        ));
  }
}
