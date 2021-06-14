import "package:flutter/material.dart";

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w300,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).primaryColor,
              child: Image(
                  image: AssetImage(
                "assets/images/logo.png",
              ))),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            "Perfil",
            Icons.person,
            () {
              Navigator.of(context).pushNamed("");
            },
          ),
          buildListTile(
            "Pedidos",
            Icons.pedal_bike,
            () {
              Navigator.of(context).pushNamed("/services");
            },
          ),
          buildListTile(
            "Proveedores de servicio",
            Icons.people,
            () {
              Navigator.of(context).pushReplacementNamed("");
            },
          ),
          buildListTile(
            "Solicitar servicio",
            Icons.directions_bike,
            () {
              Navigator.of(context).pushNamed("/request_service");
            },
          ),
        ],
      ),
    );
  }
}
