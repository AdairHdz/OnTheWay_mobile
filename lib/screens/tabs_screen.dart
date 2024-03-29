import "package:flutter/material.dart";
import 'package:on_the_way_mobile/screens/home_screen.dart';
import 'package:on_the_way_mobile/screens/services_screen.dart';
import 'package:on_the_way_mobile/screens/statistics_screen.dart';

import 'edit_profile_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  initState() {
    _pages = [
      {
        "title": "Home",
        "page": HomeScreen(),
      },
      {
        "title": "Services",
        "page": ServicesScreen(),
      },
      {
        "title": "Statistics",
        "page": StatisticsScreen(),
      },
      {
        "title": "Profile",
        "page": EditProfileScreen(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            label: "Servicios",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: "Estadísticas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
