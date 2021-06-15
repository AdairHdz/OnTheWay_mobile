import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/reviewDTO.dart';
import 'package:on_the_way_mobile/widgets/review_item.dart';

class ReviewsList extends StatefulWidget {
  final List<ReviewDTO> reviews;
  const ReviewsList(this.reviews);

  @override
  _ReviewsListState createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Container(
        height: 300,
        child: SingleChildScrollView(
          child: Container(
            height: 300,
            child: (widget.reviews == null || widget.reviews.length < 0)
                ? Text(
                    "Parece que todavía no tienes reseñas",
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemCount: widget.reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("EVIDENCIA: ${widget.reviews[index].evidence}");
                      return ReviewItem(
                        title: widget.reviews[index].title,
                        date: widget.reviews[index].dateOfReview,
                        reviewer:
                            "${widget.reviews[index].serviceRequester.names} ${widget.reviews[index].serviceRequester.lastName}",
                        score: widget.reviews[index].score,
                        details: widget.reviews[index].details,
                        evidence: widget.reviews[index].evidence,
                      );
                    }),
          ),
        ),
      ),
    );
  }
}
