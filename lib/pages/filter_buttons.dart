import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';

Padding buildFilterButton(String text) =>
    addPadding(
        Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                   
                  },
                  child: Text(text),
                ),
              ],
            ),
        ),
        left: 8.0,
        right: 8.0,
        bottom: 16.0);

Row buildFilterButtonRow(List<String> texts) =>
    Row(
      children: <Widget>[
        buildFilterButton(texts.first),
        buildFilterButton(texts.last),
      ],
    );

