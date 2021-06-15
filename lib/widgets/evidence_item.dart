import "package:flutter/material.dart";
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/widgets/image_dialog.dart';
import 'package:path/path.dart' as path;

class EvidenceItem extends StatelessWidget {
  final String name;
  final String link;
  EvidenceItem({this.name, this.link});

  String _getFileExtension() {
    return path.extension(name);
  }

  void _navigateToVideoPlayer(BuildContext context) {
    Map<String, String> args = {"fileName": _getFileName(), "link": this.link};
    Navigator.of(context).pushNamed("/video-player", arguments: args);
  }

  // void _navigateToImageViewer(BuildContext context) {
  //   Navigator.of(context).pushNamed("");
  // }

  String _getFileName() {
    String fileName = this.name.split("/").last;
    fileName = fileName.split(".").first;
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_getFileExtension() == ".mp4")
          TextButton(
              onPressed: () => _navigateToVideoPlayer(context),
              child: Text(name))
        else if (_getFileExtension() == ".jpeg" ||
            _getFileExtension() == ".jpg" ||
            _getFileExtension() == ".png" ||
            _getFileExtension() == ".gif")
          GestureDetector(
            child: Row(
              children: [
                Text(
                  _getFileName(),
                  style: TextStyle(
                      color: Colors.blue[500], fontWeight: FontWeight.w500),
                ),
              ],
            ),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) => ImageDialog(
                        link: this.link,
                      ));
            },
          ),
      ],
    );
  }
}
