import "package:flutter/material.dart";

class EvidenceItem extends StatelessWidget {
  final String name;
  EvidenceItem(this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(name),
        ),
      ],
    );
  }
}
