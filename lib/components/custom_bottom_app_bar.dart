import 'package:flutter/material.dart';
import 'package:template_name/components/colors/default_colors.dart';

class CustomBottomAppBar {
  static BottomAppBar createButtomAppBar(BuildContext context) => BottomAppBar(
        color: DefaultColors.secondaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _createBottomAppBarIcon(Icons.home),
            _createBottomAppBarIcon(Icons.kitchen),
            _createBottomAppBarIcon(Icons.search),
            _createBottomAppBarIcon(Icons.favorite_border),
          ],
        ),
      );

  static IconButton _createBottomAppBarIcon(IconData icon) => IconButton(
        icon: Icon(
          icon,
        ),
        onPressed: () {},
        iconSize: 32.0,
        color: Colors.white70,
      );
}
