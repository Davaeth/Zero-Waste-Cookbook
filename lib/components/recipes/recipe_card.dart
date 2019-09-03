import 'package:flutter/material.dart';
import 'package:template_name/components/colors/default_colors.dart';
import 'package:template_name/components/helpers/positioning.dart';
import 'package:template_name/components/multiple_tags.dart';
import 'package:template_name/components/helpers/stack_creator.dart';

class RecipeCard extends StatefulWidget {
  final List<Widget> _interior;

  RecipeCard(this._interior);

  @override
  _RecipeCardState createState() => _RecipeCardState();

  static List<Widget> createInteriorForListOfeCards(
          String imagePath, String title, String author) =>
      <Widget>[
        StackCreator.createImageWithIconButton(
            imagePath, Icons.favorite_border),
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
        StackCreator.createImageWithIconButton(
            imagePath, Icons.favorite_border),
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
          mainAxisSize: MainAxisSize.max,
          children: _interior,
        ),
      );

  @override
  void initState() {
    _interior = widget._interior;

    super.initState();
  }
}
