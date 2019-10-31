import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';


Padding buildPopularCategoriesCardButton(String text, Image assetImage) =>
    addPadding(
        Container(
          height: 158.0,
          width: 180.0,
          child: Card(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/borger.jpg'),
                addPadding(
                    Text(
                      text,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    bottom: 8.0, top: 8.0)
              ],
            ),
          ),
        ),
        left: 8.0,
        right: 8.0,
        bottom: 16.0);

Row buildFullCardPopularRow(List<String> texts, List<Image> imageData) =>
    Row(
      children: <Widget>[
        buildPopularCategoriesCardButton(texts.first, imageData.first),
        buildPopularCategoriesCardButton(texts.last, imageData.last),
      ],
    );