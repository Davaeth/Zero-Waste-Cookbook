import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';

class FavRecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavRecipesManager();
}

class _FavRecipesManager extends State<FavRecipesManager> {
  DatabaseService _db = DatabaseService();

  bool _isFav;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _db.getUserFavouriteRecipes('E5ewEF8YxDO0rl8Zue2zMrU7Yd43'),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
          if (snapshots.hasData) {
            return ListView(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: _extractFavRecipes(snapshots).toList(),
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

  Iterable<RecipeCard> _extractFavRecipes(
      AsyncSnapshot<List<DocumentSnapshot>> snapshots) sync* {
    for (var snapshot in snapshots.data) {
      yield RecipeCard(
        interior: RecipeCard.createInteriorForListOfCards(
          recipe: Recipe.fromFirestore(snapshot),
          imagePath: 'assets/images/small-food.png',
          userId: 'E5ewEF8YxDO0rl8Zue2zMrU7Yd43',
          isFav: _isFav,
          callback: (bool isFav) => _callback(isFav),
        ),
      );
    }
  }
}
