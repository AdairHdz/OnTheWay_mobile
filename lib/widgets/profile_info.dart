import "package:flutter/material.dart";

import './stars_rating.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          width: deviceWidth,
          height: (deviceHeight * 0.30),
          child: Image.network(
            "https://images.pexels.com/photos/2611690/pexels-photo-2611690.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: deviceWidth,
          child: Text(
            "MotoServicio Adonai",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            softWrap: false,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: deviceWidth,
          child: Text(
            "Hiram Adonai Serrano",
            style: TextStyle(
                fontSize: 18, color: Color.fromRGBO(180, 180, 180, 1)),
            softWrap: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const StarsRating(4),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
