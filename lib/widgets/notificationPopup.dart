import "package:flutter/material.dart";

class NotificationPopup extends StatelessWidget {
  final String title;
  final String body;
  final String buttonText;

  const NotificationPopup({this.title, this.body, this.buttonText});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(body),
          ],
        ),
      ),
      actions: [
        TextButton(
            child: Text(buttonText),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
