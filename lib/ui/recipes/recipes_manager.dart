import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';

class RecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipesManager();
}

class _RecipesManager extends State<RecipesManager> {
  DatabaseService _databaseService;

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: _databaseService.streamNewestRecipes(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.hasData) {
          return ListView(
            padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: _createRecipeDetectors(snapshots),
          );
        } else {
          return ListView();
        }
      });

  @override
  void initState() {
    _databaseService = DatabaseService();

    super.initState();
  }

  List<Container> _createRecipeDetectors(
      AsyncSnapshot<QuerySnapshot> snapshots) {
    List<Container> gestures = List<Container>();

    var docs = snapshots?.data?.documents;

    for (var snapshot in docs) {
      var recipe = Recipe.fromFirestore(snapshot);

      gestures.add(
        Container(
          height: (MediaQuery.of(context).size.height / 100) * 50,
          child: RecipeCard(
            interior: RecipeCard.createInteriorForListOfCards(
                recipe: recipe,
                imagePath: 'assets/images/small-food.png',
                userId: 'MtcBAWcygoW6ERK83agC'),
            recipeID: snapshot.documentID,
          ),
        ),
      );
    }

    return gestures;
  }
}
