import 'dart:io';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';

import './stars_rating.dart';

class ProfileInfo extends StatefulWidget {
  final String serviceProviderName;
  final int averageScore;
  final String profileImage;
  ProfileInfo({this.serviceProviderName, this.averageScore, this.profileImage});
  Session session = Session();

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  Image noImage = Image.asset("assets/images/OnTheWay.png");
  String imageUrl = "";
  @override
  void initState() {
    super.initState();
    imageUrl = widget.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
            width: deviceWidth,
            height: (deviceHeight * 0.30),
            child: FittedBox(
              child: (imageUrl !=
                      null) // Only use the network image if the url is not null
                  ? Image.network(
                      imageUrl,
                      loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : CircularProgressIndicator(),
                      errorBuilder: (context, error, stackTrace) => noImage,
                    )
                  : noImage,
              fit: BoxFit.fill,
            )),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: deviceWidth,
          child: Text(
            widget.serviceProviderName,
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
                child: StarsRating(widget.averageScore),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
