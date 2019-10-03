import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => buildNavigationBar();

  BottomNavigationBar buildNavigationBar() => BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          _buildNavigationItem(Icons.home),
          _buildNavigationItem(Icons.kitchen),
          _buildNavigationItem(Icons.search),
          _buildNavigationItem(Icons.textsms),
          _buildNavigationItem(Icons.favorite_border)
        ],
        backgroundColor: DefaultColors.secondaryColor,
        iconSize: 32.0,
        selectedItemColor: Colors.orange,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white70,
      );

  BottomNavigationBarItem _buildNavigationItem(IconData icon, {String title}) =>
      BottomNavigationBarItem(
          icon: Icon(icon),
          activeIcon: Icon(icon),
          title: Text(''),
          backgroundColor: Colors.transparent);
}
