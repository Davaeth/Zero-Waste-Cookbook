import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card/recipe_card.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/recipe_card_interior_type.dart';
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

  _callback(bool isFav) {
    setState(() {
      _isFav = isFav;
    });
  }

  Iterable<RecipeCard> _extractFavRecipes(BuildContext context,
      AsyncSnapshot<List<DocumentSnapshot>> snapshots) sync* {
    for (var snapshot in snapshots.data) {
      var recipe = Recipe.fromFirestore(snapshot);

      yield RecipeCard(
        recipeCardInteriorType: RecipeCardInteriorType.SingleRecipe,
        recipe: recipe,
        userId: currentUserId,
        iconData: _isFav ? Icons.favorite : Icons.favorite_border,
        callback: (bool isFav) => _callback(isFav),
        recipeID: recipe.id,
      );
    }
  }
}
