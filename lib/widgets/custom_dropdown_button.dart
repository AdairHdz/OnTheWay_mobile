import "package:flutter/material.dart";

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({this.hint, this.options});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();

  final String hint;
  final List<String> options;
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.hint),
      items: [
        ...widget.options.map(
          (option) {
            return DropdownMenuItem(
              child: Text(option),
              value: option,
            );
          },
        )
      ],
      value: _dropdownValue,
      onChanged: (value) {
        setState(() {
          _dropdownValue = value;
        });
      },
    );
  }
}
