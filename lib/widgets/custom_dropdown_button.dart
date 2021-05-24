import "package:flutter/material.dart";

class CustomInput {
  String child;
  String value;
  CustomInput({this.child, this.value});
}

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({this.hint, this.options});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();

  final String hint;
  final List<CustomInput> options;
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  // String _dropdownValue;

  @override
  void initState() {
    super.initState();
    // _dropdownValue = widget.options[0].value;
    // _dropdownValue = "";
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.hint),
      items: [
        if (widget.options.isNotEmpty)
          ...widget.options.map(
            (option) {
              return DropdownMenuItem(
                child: Text(option.child),
                value: option.value,
              );
            },
          )
      ],
      // value: _dropdownValue,
      onChanged: (value) {
        setState(() {
          print(value);
          // _dropdownValue = value;
        });
      },
    );
  }
}
