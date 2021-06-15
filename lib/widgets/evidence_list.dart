import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/evidenceDTO.dart';
import 'package:on_the_way_mobile/widgets/evidence_item.dart';

class EvidenceList extends StatefulWidget {
  final List<EvidenceDTO> evidence;

  const EvidenceList({this.evidence});

  @override
  _EvidenceListState createState() => _EvidenceListState();
}

class _EvidenceListState extends State<EvidenceList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 25,
      children: [
        if (widget.evidence != null)
          for (int i = 0; i < widget.evidence.length; i++)
            EvidenceItem(
              name: widget.evidence[i].name,
              link: widget.evidence[i].link,
            ),
      ],
    );
  }
}
