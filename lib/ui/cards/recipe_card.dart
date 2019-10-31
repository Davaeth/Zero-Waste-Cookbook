import 'package:flutter/material.dart';
import 'package:template_name/ui/recipes/multiple_tags.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

import '../ratings.dart';
import '../stack_builder.dart';

class RecipeCard extends StatefulWidget {
  final List<Widget> _interior;

  RecipeCard(this._interior);

  @override
  _RecipeCardState createState() => _RecipeCardState();

  static List<Widget> createInteriorForCardWithRating(String imagePath,
          String title, String author, BuildContext context) =>
      <Widget>[
        StackBuilder.createImageWithIconButtons(
            imagePath, Icons.favorite_border, context),
        addPadding(
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            left: 16.0,
            top: 8.0),
        addPadding(
            MultipleTags([MultipleTags.createTag(title)],
                cookingTimeTag:
                    MultipleTags.createTag(author, icon: Icons.access_time)),
            left: 8.0,
            top: 8.0),
        addPadding(
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Ratings(3),
                  addPadding(
                      Text(
                        '(500 votes)',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      left: 8.0)
                ]),
            top: 8.0,
            left: 16.0,
            bottom: 16.0),
      ];

  static List<Widget> createInteriorForListOfCards(
          String imagePath, String title, String author) =>
      <Widget>[
        StackBuilder.createImageWithFavButton(imagePath, Icons.favorite_border),
        addPadding(
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            left: 16.0,
            top: 8.0),
        addPadding(
            MultipleTags([MultipleTags.createTag(title)],
                cookingTimeTag:
                    MultipleTags.createTag(author, icon: Icons.access_time)),
            left: 8.0,
            top: 8.0,
            bottom: 16.0)
      ];

  static List<Widget> createInteriorForSingleCard(
          String imagePath, String title, String author) =>
      <Widget>[
        StackBuilder.createImageWithFavButton(imagePath, Icons.favorite_border),
        addPadding(
            Text('Przepis dnia',
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
            left: 16.0,
            top: 8.0),
        addPadding(
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            left: 16.0,
            top: 8.0),
        addPadding(
            MultipleTags([MultipleTags.createTag(title)],
                cookingTimeTag:
                    MultipleTags.createTag(author, icon: Icons.access_time)),
            left: 8.0,
            top: 8.0,
            bottom: 16.0)
      ];
}

class _RecipeCardState extends State<RecipeCard> {
  List<Widget> _interior;

  @override
  Widget build(BuildContext context) => Card(
        color: DefaultColors.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _interior,
        ),
      );

  @override
  void initState() {
    _interior = widget._interior;

    super.initState();
  }
}
