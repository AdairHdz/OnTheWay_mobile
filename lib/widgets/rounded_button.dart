import "package:flutter/material.dart";

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onTapHandler;
  RoundedButton(this.buttonText, this.onTapHandler);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(buttonText),
      onPressed: onTapHandler,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
            side: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
