import "package:flutter/material.dart";
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/stars_rating.dart';

class ProfileInfo extends StatefulWidget {
  final String serviceProviderName;
  final int averageScore;
  final String profileImage;
  ProfileInfo({this.serviceProviderName, this.averageScore, this.profileImage});

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  Image noImage = Image.asset("assets/images/OnTheWay.png");
  Session session = Session();
  String imageUrl;
  @override
  void initState() {
    super.initState();
    imageUrl =
        "http://192.168.100.173:8080/images/${session.id}/${widget.profileImage}";
    session.profilePicture =
        "http://192.168.100.173:8080/images/${session.id}/${widget.profileImage}";
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
                      "http://192.168.100.173:8080/images/${session.id}/${widget.profileImage}",
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
