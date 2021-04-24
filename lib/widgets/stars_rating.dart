import "package:flutter/material.dart";

class StarsRating extends StatelessWidget {
  final int score;

  const StarsRating(this.score);

  List<Widget> showStars() {
    int remainingStarsThatMustBeEmpty = 5;
    List<Icon> stars = [];
    for (int i = 0; i < score; i++) {
      remainingStarsThatMustBeEmpty--;
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow,
      ));
    }

    for (int i = 0; i < remainingStarsThatMustBeEmpty; i++) {
      stars.add(Icon(
        Icons.star_outline,
        color: Colors.yellow,
      ));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...showStars(),
      ],
    );
  }
}
