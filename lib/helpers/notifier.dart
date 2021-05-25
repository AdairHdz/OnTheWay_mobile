import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/widgets/notificationPopup.dart';

Future<void> showNotification(BuildContext context, String popupTitle,
    String popupBody, String popupButtonText) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext _) {
      return NotificationPopup(
        title: popupTitle,
        body: popupBody,
        buttonText: popupButtonText,
      );
    },
  );
}
