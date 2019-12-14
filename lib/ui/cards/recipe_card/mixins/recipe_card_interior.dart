import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/tag.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card/recipe_card.dart';
import 'package:zero_waste_cookbook/ui/ratings.dart';
import 'package:zero_waste_cookbook/ui/recipes/multiple_tags.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

mixin RecipeCardInterior on State<RecipeCard> {
  List<Widget> createInteriorForRecipeCard({
    @required BuildContext context,
    @required Recipe recipe,
    @required String userId,
    @required Function(bool) callback,
    @required bool isFaved,
    Widget ratings,
    Widget mainImage,
  }) {
    DatabaseService _dbService = DatabaseService();

    return <Widget>[
      mainImage,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          addPadding(
            Text(
              recipe.recipeTitle,
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
            left: 10.0,
            right: 10.0,
            top: 8.0,
          ),
          _createFavIconButton(
            recipeId: recipe.id,
            userId: userId,
            callback: callback,
            dbService: _dbService,
            isFaved: isFaved,
          ),
        ],
      ),
      FutureBuilder(
        future: _dbService.getRecipeTags(recipe.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            List<Tag> _tags = List<Tag>();

            _tags = _getTags(snapshots).toList();

            return addPadding(
              MultipleTags(
                _createTags(tags: _tags).toList(),
                cookingTimeTag: MultipleTags.createTag(
                  recipe.prepTime.toString(),
                  icon: Icons.access_time,
                ),
              ),
              left: 8.0,
              top: 8.0,
            );
          } else {
            return Card();
          }
        },
      ),
      if (ratings != null) ratings,
    ];
  }

  Padding buildRatings({@required Recipe recipe}) {
    return addPadding(
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[Ratings(recipe.rank.floor())],
      ),
      top: 8.0,
      left: 16.0,
      bottom: 16.0,
    );
  }

  Iterable<Card> _createTags({@required List<Tag> tags}) sync* {
    for (var tag in tags) {
      yield MultipleTags.createTag(tag.tagName);
    }
  }

  Iterable<Tag> _getTags(AsyncSnapshot<QuerySnapshot> snapshots) sync* {
    for (var snapshot in snapshots.data.documents) {
      yield Tag.fromFirestore(snapshot);
    }
  }

  IconButton _createFavIconButton({
    @required String recipeId,
    @required String userId,
    @required DatabaseService dbService,
    @required bool isFaved,
    Function(bool) callback,
  }) =>
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(isFaved ? Icons.favorite : Icons.favorite_border),
        onPressed: () => _handleFavRecipeIconButton(
          recipeId,
          userId,
          dbService,
          callback: callback,
        ),
        iconSize: 40.0,
        color: DefaultColors.iconColor,
      );

  _handleFavRecipeIconButton(
      String recipeId, String userId, DatabaseService dbService,
      {Function callback}) {
    setState(() {
      dbService.checkIfRecipeIsFaved(userId, recipeId).then((value) {
        if (value) {
          dbService.removeRecipeFromUser(recipeId, userId, 'favouriteRecipes');
          callback(true);
        } else {
          dbService.addRecipeToUser(recipeId, userId, 'favouriteRecipes');
          callback(false);
        }
      });
    });
  }
}
