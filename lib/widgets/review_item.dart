import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/evidenceDTO.dart';
import 'package:on_the_way_mobile/widgets/evidence_list.dart';
import 'package:on_the_way_mobile/widgets/stars_rating.dart';

class ReviewItem extends StatefulWidget {
  ReviewItem(
      {this.title,
      this.reviewer,
      this.date,
      this.score,
      this.details,
      this.evidence});
  String title;
  String reviewer;
  String date;
  int score;
  String details;
  List<EvidenceDTO> evidence;

  @override
  _ReviewItemState createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.reviewer,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    DateFormat.yMd().format(DateTime.parse(widget.date)),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  )),
              SizedBox(
                width: double.infinity,
                child: StarsRating(widget.score),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.details,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              EvidenceList(
                evidence: widget.evidence,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
