import "package:flutter/material.dart";

class AccentButton extends StatelessWidget {
  final Function _handler;
  final String _text;
  AccentButton(this._handler, this._text);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _handler,
      child: Text(_text),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
        elevation: MaterialStateProperty.all<double>(5),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      ),
    );
  }
}
