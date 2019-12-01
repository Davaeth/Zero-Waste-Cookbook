import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

Padding buildAdministratorCardButton(String text, IconData iconData) =>
    addPadding(
        Container(
          width: 160.0,
          child: Card(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  size: 120.0,
                ),
                addPadding(
                    Text(
                      text,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    bottom: 8.0)
              ],
            ),
          ),
        ),
        left: 16.0,
        bottom: 16.0);

Row buildFullCardButtonsRow(List<String> texts, List<IconData> iconsData) =>
    Row(
      children: <Widget>[
        buildAdministratorCardButton(texts.first, iconsData.first),
        buildAdministratorCardButton(texts.last, iconsData.last)
      ],
    );

Row buildHalfCardButtonsRow(String texts, IconData iconsData) => Row(
      children: <Widget>[buildAdministratorCardButton(texts, iconsData)],
    );
