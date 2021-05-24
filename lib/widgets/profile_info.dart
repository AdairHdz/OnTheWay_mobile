import "package:flutter/material.dart";

import './stars_rating.dart';

class ProfileInfo extends StatelessWidget {
  final String serviceProviderName;
  final int averageScore;
  const ProfileInfo({this.serviceProviderName, this.averageScore});

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
            "http://192.168.100.41:8080/images/82e49b2e-cff5-46cb-8f4f-de932cbb6cbf/OnTheWayIcon.png",
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
            serviceProviderName,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            softWrap: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: StarsRating(averageScore),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
