import 'package:flutter/material.dart';
import 'package:rowdy_hacks/landing/drawer.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Places',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}