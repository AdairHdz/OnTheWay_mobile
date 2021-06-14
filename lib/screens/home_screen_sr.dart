import "package:flutter/material.dart";
import 'package:on_the_way_mobile/widgets/main_drawer.dart';

class HomeScreenSr extends StatelessWidget {
  static final String routeName = "/homesr";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      body: Container(
        child: Center(
          child: Image(
            image: AssetImage(
              "assets/images/logo-black.png",
            ),
          ),
        ),
      ),
    );
  }
}
