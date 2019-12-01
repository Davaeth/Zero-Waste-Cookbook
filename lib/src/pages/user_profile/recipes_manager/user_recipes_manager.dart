import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import 'components/user_recipes_manager_item.dart';

class UserRecipesManager extends StatefulWidget {
  @override
  _UserRecipesManagerState createState() => _UserRecipesManagerState();
}

class _UserRecipesManagerState extends State<UserRecipesManager> {
  DatabaseService _databaseService;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: StreamBuilder(
            stream: _databaseService.getUserRecipes('id'),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
              var recipes = _getRecipesInfo(snapshots);

              ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => addPadding(
                  UserRecipesManagerItem(
                    title: recipes[index].recipeTitle,
                    rate: double.parse(recipes[index].rank.toString()),
                  ),
                  top: 16.0,
                ),
              );
            }),
      );

  @override
  void initState() {
    _databaseService = DatabaseService();

    super.initState();
  }

  List<Recipe> _getRecipesInfo(AsyncSnapshot<QuerySnapshot> snapshots) {
    List<Recipe> recipeInfo = List<Recipe>();

    for (var snapshot in snapshots.data.documents) {
      recipeInfo.add(Recipe.fromFirestore(snapshot));
    }

    return recipeInfo;
  }
}
