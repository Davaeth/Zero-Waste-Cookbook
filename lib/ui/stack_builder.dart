import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';

import 'shared/colors/default_colors.dart';

class StackBuilder {
  static Stack createImageWithFavButton(String imagePath, IconData icon) =>
      Stack(alignment: Alignment.topRight, children: <Widget>[
        Image.asset(imagePath),
        _createFavIconButton(icon)
      ]);

  static Stack createImageWithIconButtons(
          String imagePath, IconData icon, BuildContext context) =>
      Stack(alignment: Alignment.topRight, children: <Widget>[
        Image.asset(imagePath),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              stepPageBack(context);
            },
            iconSize: 24.0,
            color: DefaultColors.iconColor,
          ),
        ),
        _createFavIconButton(icon)
      ]);

  static IconButton _createFavIconButton(IconData icon) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(icon),
      onPressed: () {},
      iconSize: 40.0,
      color: DefaultColors.iconColor,
    );
  }
}
