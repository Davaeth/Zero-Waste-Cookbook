import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';

class StackBuilder {
  static Stack createImageWithIconButton(String imagePath, IconData icon) =>
      Stack(alignment: Alignment.topRight, children: <Widget>[
        Image.asset(imagePath),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(icon),
          onPressed: () {},
          iconSize: 40.0,
          color: DefaultColors.iconColor,
        )
      ]);
}
