import 'package:flutter/material.dart';
import 'package:template_name/components/colors/default_colors.dart';

class StackCreator {
  static Stack createImageWithIconButton(String imagePath, IconData icon) =>
      Stack(alignment: Alignment.topRight, children: <Widget>[
        Image.asset(imagePath),
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
          iconSize: 40.0,
          color: DefaultColors.iconColor,
        )
      ]);
}
