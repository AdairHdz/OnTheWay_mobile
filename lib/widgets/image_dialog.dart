import "package:flutter/material.dart";

class ImageDialog extends StatelessWidget {
  @required
  final String link;

  const ImageDialog({Key key, this.link}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("http://192.168.100.173:8080/$link"))),
      ),
    );
  }
}
