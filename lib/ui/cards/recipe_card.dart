import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/tag.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/recipes/multiple_tags.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import '../ratings.dart';
import '../stack_builder.dart';

class RecipeCard extends StatefulWidget {
  static List<Tag> _tags;

  final List<Widget> interior;

  final String recipeID;

  final bool isTappable;

  RecipeCard({@required this.interior, this.recipeID, this.isTappable = true});

  @override
  _RecipeCardState createState() => _RecipeCardState();

  static List<Widget> createInteriorForCardWithRating(
      {@required String imagePath,
      @required Recipe recipe,
      @required BuildContext context,
      @required String userId,
      @required bool isFav,
      Function(bool) callback}) {
    DatabaseService _dbService = DatabaseService();

    return <Widget>[
      StackBuilder.createImageWithIconButtons(
          imagePath: imagePath,
          isFav: isFav,
          recipeId: recipe.id,
          userId: userId,
          context: context,
          callback: callback),
      addPadding(
          Text(
            recipe.recipeTitle,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          left: 16.0,
          top: 8.0),
      FutureBuilder(
        future: _dbService.getRecipeTags(recipe.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            _getTags(snapshots);

            return addPadding(
                MultipleTags(
                  _createTags().toList(),
                  cookingTimeTag: MultipleTags.createTag(
                      recipe.prepTime.toString(),
                      icon: Icons.access_time),
                ),
                left: 8.0,
                top: 8.0);
          } else {
            return Card();
          }
        },
      ),
      addPadding(
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Ratings(recipe.rank)],
          ),
          top: 8.0,
          left: 16.0,
          bottom: 16.0),
    ];
  }

  static List<Widget> createInteriorForListOfCards(
      {@required Recipe recipe,
      @required String imagePath,
      @required bool isFav,
      @required String userId,
      Function(bool) callback}) {
    DatabaseService _dbService = DatabaseService();

    return <Widget>[
      StackBuilder.createImageWithFavButton(
          imagePath: imagePath,
          isFav: isFav,
          recipeId: recipe.id,
          userId: userId,
          callback: callback),
      addPadding(
          Text(
            recipe.recipeTitle,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          left: 16.0,
          top: 8.0),
      FutureBuilder(
        future: _dbService.getRecipeTags(recipe.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            _getTags(snapshots);

            return addPadding(
                MultipleTags(
                  _createTags().toList(),
                  cookingTimeTag: MultipleTags.createTag(
                      recipe.prepTime.toString(),
                      icon: Icons.access_time),
                ),
                left: 8.0,
                top: 8.0);
          } else {
            return Card();
          }
        },
      ),
    ];
  }

  static List<Widget> createInteriorForSingleCard(
      {@required Recipe recipe,
      @required String imagePath,
      @required String userId,
      @required bool isFav,
      Function(bool) callback}) {
    DatabaseService _dbService = DatabaseService();

    return <Widget>[
      StackBuilder.createImageWithFavButton(
          imagePath: imagePath,
          isFav: isFav,
          recipeId: recipe.id,
          userId: userId,
          callback: callback),
      addPadding(
          Text(
            'Przepis dnia',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          left: 16.0,
          top: 8.0),
      addPadding(
          Text(
            recipe.recipeTitle,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          left: 16.0,
          top: 8.0),
      FutureBuilder(
        future: _dbService.getRecipeTags(recipe.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            _getTags(snapshots);

            return addPadding(
                MultipleTags(
                  _createTags().toList(),
                  cookingTimeTag: MultipleTags.createTag(
                      recipe.prepTime.toString(),
                      icon: Icons.access_time),
                ),
                left: 8.0,
                top: 8.0);
          } else {
            return Card();
          }
        },
      ),
    ];
  }

  static Iterable<Card> _createTags() sync* {
    for (var tag in _tags) {
      yield MultipleTags.createTag(tag.tagName);
    }
  }

  static void _getTags(AsyncSnapshot<QuerySnapshot> snapshots) {
    _tags = List<Tag>();

    for (var snapshot in snapshots.data.documents) {
      _tags.add(Tag.fromFirestore(snapshot));
    }
  }
}

class _RecipeCardState extends State<RecipeCard> {
  List<Widget> _interior;
  String _recipeId;
  bool _isTappable;

  @override
  Widget build(BuildContext context) => switchPage(
      context,
      Card(
        color: DefaultColors.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _interior,
        ),
      ),
      Routes.Recipe,
      recipeId: _recipeId,
      isTappable: _isTappable);

  @override
  void initState() {
    _interior = widget.interior;
    _recipeId = widget.recipeID;
    _isTappable = widget.isTappable;

    super.initState();
  }
}
