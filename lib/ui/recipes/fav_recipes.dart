import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';

class FavRecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavRecipesManager();
}

class _FavRecipesManager extends State<FavRecipesManager> {
  DatabaseService _db = DatabaseService();

  bool _isFav;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _db.getUserFavouriteRecipes(currentUserId),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
          if (snapshots.hasData) {
            return ListView(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: _extractFavRecipes(context, snapshots).toList(),
            );
          } else {
            return ListView();
          }
        },
      );

  @override
  void initState() {
    _isFav = false;

    super.initState();
  }

  _callback(bool ifFav) {
    setState(() {
      _isFav = _isFav;
    });
  }

  Iterable<RecipeCard> _extractFavRecipes(BuildContext context,
      AsyncSnapshot<List<DocumentSnapshot>> snapshots) sync* {
    for (var snapshot in snapshots.data) {
      var recipe = Recipe.fromFirestore(snapshot);

      yield RecipeCard(
        interior: RecipeCard.createInteriorForListOfCards(
          context: context,
          recipe: recipe,
          userId: currentUserId,
          isFav: _isFav,
          callback: (bool isFav) => _callback(isFav),
        ),
        recipeID: recipe.id,
      );
    }
  }
}
